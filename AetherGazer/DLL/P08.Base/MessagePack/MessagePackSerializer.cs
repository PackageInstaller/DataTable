using System;
using System.Buffers;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using MessagePack.Formatters;
using MessagePack.Internal;
using MessagePack.LZ4;
using Nerdbank.Streams;

namespace MessagePack;

public static class MessagePackSerializer
{
	private delegate int LZ4Transform(ReadOnlySpan<byte> input, Span<byte> output);

	private static class PrimitiveChecker<T>
	{
		public static readonly bool IsMessagePackFixedSizePrimitive;

		static PrimitiveChecker()
		{
			IsMessagePackFixedSizePrimitive = IsMessagePackFixedSizePrimitiveTypeHelper(typeof(T));
		}
	}

	private class CompiledMethods
	{
		internal delegate void MessagePackWriterSerialize(ref MessagePackWriter writer, object value, MessagePackSerializerOptions options);

		internal delegate object MessagePackReaderDeserialize(ref MessagePackReader reader, MessagePackSerializerOptions options);

		private const bool PreferInterpretation = true;

		internal readonly Func<object, MessagePackSerializerOptions, CancellationToken, byte[]> Serialize_T_Options;

		internal readonly Action<Stream, object, MessagePackSerializerOptions, CancellationToken> Serialize_Stream_T_Options_CancellationToken;

		internal readonly Func<Stream, object, MessagePackSerializerOptions, CancellationToken, Task> SerializeAsync_Stream_T_Options_CancellationToken;

		internal readonly MessagePackWriterSerialize Serialize_MessagePackWriter_T_Options;

		internal readonly Action<IBufferWriter<byte>, object, MessagePackSerializerOptions, CancellationToken> Serialize_IBufferWriter_T_Options_CancellationToken;

		internal readonly MessagePackReaderDeserialize Deserialize_MessagePackReader_Options;

		internal readonly Func<Stream, MessagePackSerializerOptions, CancellationToken, object> Deserialize_Stream_Options_CancellationToken;

		internal readonly Func<Stream, MessagePackSerializerOptions, CancellationToken, ValueTask<object>> DeserializeAsync_Stream_Options_CancellationToken;

		internal readonly Func<ReadOnlyMemory<byte>, MessagePackSerializerOptions, CancellationToken, object> Deserialize_ReadOnlyMemory_Options;

		internal readonly Func<ReadOnlySequence<byte>, MessagePackSerializerOptions, CancellationToken, object> Deserialize_ReadOnlySequence_Options_CancellationToken;

		internal CompiledMethods(Type type)
		{
			type.GetTypeInfo();
			MethodInfo serialize = GetMethod("Serialize", type, new Type[3]
			{
				null,
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Serialize_T_Options = (object x, MessagePackSerializerOptions y, CancellationToken z) => (byte[])serialize.Invoke(null, new object[3] { x, y, z });
			MethodInfo serialize2 = GetMethod("Serialize", type, new Type[4]
			{
				typeof(Stream),
				null,
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Serialize_Stream_T_Options_CancellationToken = delegate(Stream x, object y, MessagePackSerializerOptions z, CancellationToken a)
			{
				serialize2.Invoke(null, new object[4] { x, y, z, a });
			};
			MethodInfo serialize3 = GetMethod("SerializeAsync", type, new Type[4]
			{
				typeof(Stream),
				null,
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			SerializeAsync_Stream_T_Options_CancellationToken = (Stream x, object y, MessagePackSerializerOptions z, CancellationToken a) => (Task)serialize3.Invoke(null, new object[4] { x, y, z, a });
			MethodInfo serialize4 = GetMethod("Serialize", type, new Type[4]
			{
				typeof(IBufferWriter<byte>),
				null,
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Serialize_IBufferWriter_T_Options_CancellationToken = delegate(IBufferWriter<byte> x, object y, MessagePackSerializerOptions z, CancellationToken a)
			{
				serialize4.Invoke(null, new object[4] { x, y, z, a });
			};
			GetMethod("Serialize", type, new Type[3]
			{
				typeof(MessagePackWriter).MakeByRefType(),
				null,
				typeof(MessagePackSerializerOptions)
			});
			Serialize_MessagePackWriter_T_Options = delegate
			{
				ThrowRefStructNotSupported();
			};
			GetMethod("Deserialize", type, new Type[2]
			{
				typeof(MessagePackReader).MakeByRefType(),
				typeof(MessagePackSerializerOptions)
			});
			Deserialize_MessagePackReader_Options = delegate
			{
				ThrowRefStructNotSupported();
				return (object)null;
			};
			MethodInfo deserialize = GetMethod("Deserialize", type, new Type[3]
			{
				typeof(Stream),
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Deserialize_Stream_Options_CancellationToken = (Stream x, MessagePackSerializerOptions y, CancellationToken z) => deserialize.Invoke(null, new object[3] { x, y, z });
			MethodInfo deserialize2 = GetMethod("DeserializeObjectAsync", type, new Type[3]
			{
				typeof(Stream),
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			DeserializeAsync_Stream_Options_CancellationToken = (Stream x, MessagePackSerializerOptions y, CancellationToken z) => (ValueTask<object>)deserialize2.Invoke(null, new object[3] { x, y, z });
			MethodInfo deserialize3 = GetMethod("Deserialize", type, new Type[3]
			{
				typeof(ReadOnlyMemory<byte>),
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Deserialize_ReadOnlyMemory_Options = (ReadOnlyMemory<byte> x, MessagePackSerializerOptions y, CancellationToken z) => deserialize3.Invoke(null, new object[3] { x, y, z });
			MethodInfo deserialize4 = GetMethod("Deserialize", type, new Type[3]
			{
				typeof(ReadOnlySequence<byte>).MakeByRefType(),
				typeof(MessagePackSerializerOptions),
				typeof(CancellationToken)
			});
			Deserialize_ReadOnlySequence_Options_CancellationToken = (ReadOnlySequence<byte> x, MessagePackSerializerOptions y, CancellationToken z) => deserialize4.Invoke(null, new object[3] { x, y, z });
		}

		private static void ThrowRefStructNotSupported()
		{
			throw new NotSupportedException("MessagePackWriter/Reader overload is not supported in MessagePackSerializer.NonGenerics.");
		}

		private static MethodInfo GetMethod(string methodName, Type type, Type[] parameters)
		{
			return typeof(MessagePackSerializer).GetRuntimeMethods().Single(delegate(MethodInfo x)
			{
				if (methodName != x.Name)
				{
					return false;
				}
				ParameterInfo[] parameters2 = x.GetParameters();
				if (parameters2.Length != parameters.Length)
				{
					return false;
				}
				for (int i = 0; i < parameters2.Length; i++)
				{
					if ((!(parameters[i] == null) || !parameters2[i].ParameterType.IsGenericParameter) && parameters2[i].ParameterType != parameters[i])
					{
						return false;
					}
				}
				return true;
			}).MakeGenericMethod(type);
		}
	}

	private const int LZ4NotCompressionSizeInLz4BlockType = 64;

	private const int MaxHintSize = 1048576;

	[ThreadStatic]
	private static byte[] scratchArray;

	private static readonly LZ4Transform LZ4CodecEncode;

	private static readonly LZ4Transform LZ4CodecDecode;

	private static readonly Func<Type, CompiledMethods> CreateCompiledMethods;

	private static readonly ThreadsafeTypeKeyHashTable<CompiledMethods> Serializes;

	public static MessagePackSerializerOptions DefaultOptions { get; set; }

	public static void Serialize<T>(IBufferWriter<byte> writer, T value, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		MessagePackWriter messagePackWriter = new MessagePackWriter(writer);
		messagePackWriter.CancellationToken = cancellationToken;
		MessagePackWriter writer2 = messagePackWriter;
		Serialize(ref writer2, value, options);
		writer2.Flush();
	}

	public static void Serialize<T>(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options = null)
	{
		options = options ?? DefaultOptions;
		bool oldSpec = writer.OldSpec;
		if (options.OldSpec.HasValue)
		{
			writer.OldSpec = options.OldSpec.Value;
		}
		try
		{
			if (options.Compression.IsCompression() && !PrimitiveChecker<T>.IsMessagePackFixedSizePrimitive)
			{
				using (SequencePool.Rental rental = options.SequencePool.Rent())
				{
					Sequence<byte> value2 = rental.Value;
					MessagePackWriter writer2 = writer.Clone(value2);
					options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer2, value, options);
					writer2.Flush();
					ToLZ4BinaryCore((ReadOnlySequence<byte>)value2, ref writer, options.Compression);
					return;
				}
			}
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value, options);
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Failed to serialize " + typeof(T).FullName + " value.", inner);
		}
		finally
		{
			writer.OldSpec = oldSpec;
		}
	}

	public static byte[] Serialize<T>(T value, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		byte[] array = scratchArray;
		if (array == null)
		{
			array = (scratchArray = new byte[65536]);
		}
		options = options ?? DefaultOptions;
		MessagePackWriter messagePackWriter = new MessagePackWriter(options.SequencePool, array);
		messagePackWriter.CancellationToken = cancellationToken;
		MessagePackWriter writer = messagePackWriter;
		Serialize(ref writer, value, options);
		return writer.FlushAndGetArray();
	}

	public static void Serialize<T>(Stream stream, T value, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		cancellationToken.ThrowIfCancellationRequested();
		using SequencePool.Rental rental = options.SequencePool.Rent();
		Serialize(rental.Value, value, options, cancellationToken);
		try
		{
			foreach (ReadOnlyMemory<byte> item in rental.Value.AsReadOnlySequence)
			{
				cancellationToken.ThrowIfCancellationRequested();
				stream.Write(item.Span);
			}
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Error occurred while writing the serialized data to the stream.", inner);
		}
	}

	public static async Task SerializeAsync<T>(Stream stream, T value, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		cancellationToken.ThrowIfCancellationRequested();
		using SequencePool.Rental sequenceRental = options.SequencePool.Rent();
		Serialize(sequenceRental.Value, value, options, cancellationToken);
		try
		{
			foreach (ReadOnlyMemory<byte> item in sequenceRental.Value.AsReadOnlySequence)
			{
				cancellationToken.ThrowIfCancellationRequested();
				await stream.WriteAsync(item, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Error occurred while writing the serialized data to the stream.", inner);
		}
	}

	public static T Deserialize<T>(in ReadOnlySequence<byte> byteSequence, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		MessagePackReader messagePackReader = new MessagePackReader(in byteSequence);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		return Deserialize<T>(ref reader, options);
	}

	public static T Deserialize<T>(ref MessagePackReader reader, MessagePackSerializerOptions options = null)
	{
		options = options ?? DefaultOptions;
		try
		{
			if (options.Compression.IsCompression())
			{
				using (SequencePool.Rental rental = options.SequencePool.Rent())
				{
					Sequence<byte> value = rental.Value;
					if (TryDecompress(ref reader, value))
					{
						MessagePackReader reader2 = reader.Clone(value.AsReadOnlySequence);
						return options.Resolver.GetFormatterWithVerify<T>().Deserialize(ref reader2, options);
					}
					return options.Resolver.GetFormatterWithVerify<T>().Deserialize(ref reader, options);
				}
			}
			return options.Resolver.GetFormatterWithVerify<T>().Deserialize(ref reader, options);
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Failed to deserialize " + typeof(T).FullName + " value.", inner);
		}
	}

	public static T Deserialize<T>(ReadOnlyMemory<byte> buffer, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		MessagePackReader messagePackReader = new MessagePackReader(buffer);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		return Deserialize<T>(ref reader, options);
	}

	public static T Deserialize<T>(ReadOnlyMemory<byte> buffer, out int bytesRead, CancellationToken cancellationToken = default(CancellationToken))
	{
		return Deserialize<T>(buffer, null, out bytesRead, cancellationToken);
	}

	public static T Deserialize<T>(ReadOnlyMemory<byte> buffer, MessagePackSerializerOptions options, out int bytesRead, CancellationToken cancellationToken = default(CancellationToken))
	{
		MessagePackReader messagePackReader = new MessagePackReader(buffer);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		T result = Deserialize<T>(ref reader, options);
		bytesRead = buffer.Slice(0, (int)reader.Consumed).Length;
		return result;
	}

	public static T Deserialize<T>(Stream stream, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		if (TryDeserializeFromMemoryStream<T>(stream, options, cancellationToken, out var result))
		{
			return result;
		}
		using SequencePool.Rental rental = options.SequencePool.Rent();
		Sequence<byte> value = rental.Value;
		try
		{
			int num;
			do
			{
				cancellationToken.ThrowIfCancellationRequested();
				Span<byte> span = value.GetSpan((int)(stream.CanSeek ? Math.Min(1048576L, stream.Length - stream.Position) : 0));
				num = stream.Read(span);
				value.Advance(num);
			}
			while (num > 0);
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Error occurred while reading from the stream.", inner);
		}
		return DeserializeFromSequenceAndRewindStreamIfPossible<T>(stream, options, value, cancellationToken);
	}

	public static async ValueTask<T> DeserializeAsync<T>(Stream stream, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		if (TryDeserializeFromMemoryStream<T>(stream, options, cancellationToken, out var result))
		{
			return result;
		}
		using SequencePool.Rental sequenceRental = options.SequencePool.Rent();
		Sequence<byte> sequence = sequenceRental.Value;
		try
		{
			int num;
			do
			{
				Memory<byte> memory = sequence.GetMemory((int)(stream.CanSeek ? Math.Min(1048576L, stream.Length - stream.Position) : 0));
				num = await stream.ReadAsync(memory, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				sequence.Advance(num);
			}
			while (num > 0);
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Error occurred while reading from the stream.", inner);
		}
		return DeserializeFromSequenceAndRewindStreamIfPossible<T>(stream, options, sequence, cancellationToken);
	}

	private static bool TryDeserializeFromMemoryStream<T>(Stream stream, MessagePackSerializerOptions options, CancellationToken cancellationToken, out T result)
	{
		cancellationToken.ThrowIfCancellationRequested();
		if (stream is MemoryStream memoryStream && memoryStream.TryGetBuffer(out var buffer))
		{
			result = Deserialize<T>(buffer.AsMemory(checked((int)memoryStream.Position)), options, out var bytesRead, cancellationToken);
			memoryStream.Seek(bytesRead, SeekOrigin.Current);
			return true;
		}
		result = default(T);
		return false;
	}

	private static T DeserializeFromSequenceAndRewindStreamIfPossible<T>(Stream streamToRewind, MessagePackSerializerOptions options, ReadOnlySequence<byte> sequence, CancellationToken cancellationToken)
	{
		if (streamToRewind == null)
		{
			throw new ArgumentNullException("streamToRewind");
		}
		MessagePackReader messagePackReader = new MessagePackReader(in sequence);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		T result = Deserialize<T>(ref reader, options);
		if (streamToRewind.CanSeek && !reader.End)
		{
			int num = checked((int)reader.Sequence.Slice(reader.Position).Length);
			streamToRewind.Seek(-num, SeekOrigin.Current);
		}
		return result;
	}

	private static int LZ4Operation(in ReadOnlySequence<byte> input, Span<byte> output, LZ4Transform lz4Operation)
	{
		byte[] array = null;
		ReadOnlySpan<byte> input2;
		if (input.IsSingleSegment)
		{
			input2 = input.First.Span;
		}
		else
		{
			array = ArrayPool<byte>.Shared.Rent((int)input.Length);
			input.CopyTo(array);
			input2 = array.AsSpan(0, (int)input.Length);
		}
		try
		{
			return lz4Operation(input2, output);
		}
		finally
		{
			if (array != null)
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
	}

	private static bool TryDecompress(ref MessagePackReader reader, IBufferWriter<byte> writer)
	{
		if (!reader.End)
		{
			ReadOnlySequence<byte> input;
			Span<byte> span;
			if (reader.NextMessagePackType == MessagePackType.Extension && reader.CreatePeekReader().ReadExtensionFormatHeader().TypeCode == 99)
			{
				input = reader.ReadExtensionFormat().Data;
				MessagePackReader messagePackReader = new MessagePackReader(in input);
				int num = messagePackReader.ReadInt32();
				input = messagePackReader.Sequence;
				ReadOnlySequence<byte> input2 = input.Slice(messagePackReader.Position);
				span = writer.GetSpan(num);
				Span<byte> output = span.Slice(0, num);
				int count = LZ4Operation(in input2, output, LZ4CodecDecode);
				writer.Advance(count);
				return true;
			}
			if (reader.NextMessagePackType == MessagePackType.Array)
			{
				MessagePackReader messagePackReader2 = reader.CreatePeekReader();
				int num2 = messagePackReader2.ReadArrayHeader();
				if (num2 != 0 && messagePackReader2.NextMessagePackType == MessagePackType.Extension && messagePackReader2.ReadExtensionFormatHeader().TypeCode == 98)
				{
					reader = messagePackReader2;
					int num3 = num2 - 1;
					int[] array = ArrayPool<int>.Shared.Rent(num3);
					try
					{
						for (int i = 0; i < num3; i++)
						{
							array[i] = reader.ReadInt32();
						}
						for (int j = 0; j < num3; j++)
						{
							int num4 = array[j];
							ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
							span = writer.GetSpan(num4);
							Span<byte> output2 = span.Slice(0, num4);
							input = readOnlySequence.Value;
							int count2 = LZ4Operation(in input, output2, LZ4CodecDecode);
							writer.Advance(count2);
						}
						return true;
					}
					finally
					{
						ArrayPool<int>.Shared.Return(array);
					}
				}
			}
		}
		return false;
	}

	private static void ToLZ4BinaryCore(in ReadOnlySequence<byte> msgpackUncompressedData, ref MessagePackWriter writer, MessagePackCompression compression)
	{
		switch (compression)
		{
		case MessagePackCompression.Lz4Block:
		{
			if (msgpackUncompressedData.Length < 64)
			{
				writer.WriteRaw(in msgpackUncompressedData);
				break;
			}
			int minimumLength = LZ4Codec.MaximumOutputLength((int)msgpackUncompressedData.Length);
			byte[] array = ArrayPool<byte>.Shared.Rent(minimumLength);
			try
			{
				int num5 = LZ4Operation(in msgpackUncompressedData, array, LZ4CodecEncode);
				writer.WriteExtensionFormatHeader(new ExtensionHeader(99, (uint)(5 + num5)));
				writer.WriteInt32((int)msgpackUncompressedData.Length);
				writer.WriteRaw(array.AsSpan(0, num5));
				break;
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
		case MessagePackCompression.Lz4BlockArray:
		{
			int num = 0;
			int num2 = 0;
			foreach (ReadOnlyMemory<byte> msgpackUncompressedDatum in msgpackUncompressedData)
			{
				num++;
				num2 += GetUInt32WriteSize((uint)msgpackUncompressedDatum.Length);
			}
			writer.WriteArrayHeader(num + 1);
			writer.WriteExtensionFormatHeader(new ExtensionHeader(98, num2));
			foreach (ReadOnlyMemory<byte> msgpackUncompressedDatum2 in msgpackUncompressedData)
			{
				writer.Write(msgpackUncompressedDatum2.Length);
			}
			foreach (ReadOnlyMemory<byte> msgpackUncompressedDatum3 in msgpackUncompressedData)
			{
				int num3 = LZ4Codec.MaximumOutputLength(msgpackUncompressedDatum3.Length);
				Span<byte> span = writer.GetSpan(num3 + 5);
				int num4 = LZ4Codec.Encode(msgpackUncompressedDatum3.Span, span.Slice(5, span.Length - 5));
				WriteBin32Header((uint)num4, span);
				writer.Advance(num4 + 5);
			}
			break;
		}
		default:
			throw new ArgumentException("Invalid MessagePackCompression Code. Code:" + compression);
		}
	}

	private static int GetUInt32WriteSize(uint value)
	{
		if (value <= 127)
		{
			return 1;
		}
		if (value <= 255)
		{
			return 2;
		}
		if (value <= 65535)
		{
			return 3;
		}
		return 5;
	}

	private static void WriteBin32Header(uint value, Span<byte> span)
	{
		span[0] = 198;
		span[4] = (byte)value;
		span[3] = (byte)(value >> 8);
		span[2] = (byte)(value >> 16);
		span[1] = (byte)(value >> 24);
	}

	private static bool IsMessagePackFixedSizePrimitiveTypeHelper(Type type)
	{
		if (!(type == typeof(short)) && !(type == typeof(int)) && !(type == typeof(long)) && !(type == typeof(ushort)) && !(type == typeof(uint)) && !(type == typeof(ulong)) && !(type == typeof(float)) && !(type == typeof(double)) && !(type == typeof(bool)) && !(type == typeof(byte)) && !(type == typeof(sbyte)))
		{
			return type == typeof(char);
		}
		return true;
	}

	public static void SerializeToJson<T>(TextWriter textWriter, T obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		using SequencePool.Rental rental = options.SequencePool.Rent();
		MessagePackWriter messagePackWriter = new MessagePackWriter(rental.Value);
		messagePackWriter.CancellationToken = cancellationToken;
		MessagePackWriter writer = messagePackWriter;
		Serialize(ref writer, obj, options);
		writer.Flush();
		MessagePackReader messagePackReader = new MessagePackReader((ReadOnlySequence<byte>)rental.Value);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		ConvertToJson(ref reader, textWriter, options);
	}

	public static string SerializeToJson<T>(T obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		StringWriter stringWriter = new StringWriter();
		SerializeToJson(stringWriter, obj, options, cancellationToken);
		return stringWriter.ToString();
	}

	public static string ConvertToJson(ReadOnlyMemory<byte> bytes, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return ConvertToJson(new ReadOnlySequence<byte>(bytes), options, cancellationToken);
	}

	public static string ConvertToJson(in ReadOnlySequence<byte> bytes, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		StringWriter stringWriter = new StringWriter();
		MessagePackReader messagePackReader = new MessagePackReader(in bytes);
		messagePackReader.CancellationToken = cancellationToken;
		MessagePackReader reader = messagePackReader;
		ConvertToJson(ref reader, stringWriter, options);
		return stringWriter.ToString();
	}

	public static void ConvertToJson(ref MessagePackReader reader, TextWriter jsonWriter, MessagePackSerializerOptions options = null)
	{
		if (reader.End)
		{
			return;
		}
		options = options ?? DefaultOptions;
		try
		{
			if (options.Compression.IsCompression())
			{
				using (SequencePool.Rental rental = options.SequencePool.Rent())
				{
					if (TryDecompress(ref reader, rental.Value))
					{
						MessagePackReader messagePackReader = new MessagePackReader((ReadOnlySequence<byte>)rental.Value);
						messagePackReader.CancellationToken = reader.CancellationToken;
						MessagePackReader reader2 = messagePackReader;
						if (!reader2.End)
						{
							ToJsonCore(ref reader2, jsonWriter, options);
						}
					}
					else
					{
						ToJsonCore(ref reader, jsonWriter, options);
					}
					return;
				}
			}
			ToJsonCore(ref reader, jsonWriter, options);
		}
		catch (Exception inner)
		{
			throw new MessagePackSerializationException("Error occurred while translating msgpack to JSON.", inner);
		}
	}

	public static void ConvertFromJson(string str, ref MessagePackWriter writer, MessagePackSerializerOptions options = null)
	{
		using StringReader reader = new StringReader(str);
		ConvertFromJson(reader, ref writer, options);
	}

	public static byte[] ConvertFromJson(string str, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		options = options ?? DefaultOptions;
		using SequencePool.Rental rental = options.SequencePool.Rent();
		MessagePackWriter messagePackWriter = new MessagePackWriter(rental.Value);
		messagePackWriter.CancellationToken = cancellationToken;
		MessagePackWriter writer = messagePackWriter;
		using (StringReader reader = new StringReader(str))
		{
			ConvertFromJson(reader, ref writer, options);
		}
		writer.Flush();
		return rental.Value.AsReadOnlySequence.ToArray<byte>();
	}

	public static void ConvertFromJson(TextReader reader, ref MessagePackWriter writer, MessagePackSerializerOptions options = null)
	{
		options = options ?? DefaultOptions;
		if (options.Compression.IsCompression())
		{
			using (SequencePool.Rental rental = options.SequencePool.Rent())
			{
				MessagePackWriter writer2 = writer.Clone(rental.Value);
				using (TinyJsonReader jr = new TinyJsonReader(reader, disposeInnerReader: false))
				{
					FromJsonCore(jr, ref writer2, options);
				}
				writer2.Flush();
				ToLZ4BinaryCore((ReadOnlySequence<byte>)rental.Value, ref writer, options.Compression);
				return;
			}
		}
		using TinyJsonReader jr2 = new TinyJsonReader(reader, disposeInnerReader: false);
		FromJsonCore(jr2, ref writer, options);
	}

	private static uint FromJsonCore(TinyJsonReader jr, ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		uint num = 0u;
		while (jr.Read())
		{
			switch (jr.TokenType)
			{
			case TinyJsonToken.StartObject:
			{
				using (SequencePool.Rental rental2 = options.SequencePool.Rent())
				{
					MessagePackWriter writer3 = writer.Clone(rental2.Value);
					uint num2 = FromJsonCore(jr, ref writer3, options);
					writer3.Flush();
					num2 /= 2;
					writer.WriteMapHeader(num2);
					writer.WriteRaw((ReadOnlySequence<byte>)rental2.Value);
				}
				num++;
				break;
			}
			case TinyJsonToken.EndObject:
				return num;
			case TinyJsonToken.StartArray:
			{
				using (SequencePool.Rental rental = options.SequencePool.Rent())
				{
					MessagePackWriter writer2 = writer.Clone(rental.Value);
					uint count = FromJsonCore(jr, ref writer2, options);
					writer2.Flush();
					writer.WriteArrayHeader(count);
					writer.WriteRaw((ReadOnlySequence<byte>)rental.Value);
				}
				num++;
				break;
			}
			case TinyJsonToken.EndArray:
				return num;
			case TinyJsonToken.Number:
				switch (jr.ValueType)
				{
				case ValueType.Double:
					writer.Write(jr.DoubleValue);
					break;
				case ValueType.Long:
					writer.Write(jr.LongValue);
					break;
				case ValueType.ULong:
					writer.Write(jr.ULongValue);
					break;
				case ValueType.Decimal:
					DecimalFormatter.Instance.Serialize(ref writer, jr.DecimalValue, null);
					break;
				}
				num++;
				break;
			case TinyJsonToken.String:
				writer.Write(jr.StringValue);
				num++;
				break;
			case TinyJsonToken.True:
				writer.Write(value: true);
				num++;
				break;
			case TinyJsonToken.False:
				writer.Write(value: false);
				num++;
				break;
			case TinyJsonToken.Null:
				writer.WriteNil();
				num++;
				break;
			}
		}
		return num;
	}

	private static void ToJsonCore(ref MessagePackReader reader, TextWriter writer, MessagePackSerializerOptions options)
	{
		switch (reader.NextMessagePackType)
		{
		case MessagePackType.Integer:
			if (MessagePackCode.IsSignedInteger(reader.NextCode))
			{
				writer.Write(reader.ReadInt64().ToString(CultureInfo.InvariantCulture));
			}
			else
			{
				writer.Write(reader.ReadUInt64().ToString(CultureInfo.InvariantCulture));
			}
			break;
		case MessagePackType.Boolean:
			writer.Write(reader.ReadBoolean() ? "true" : "false");
			break;
		case MessagePackType.Float:
			if (reader.NextCode == 202)
			{
				writer.Write(reader.ReadSingle().ToString(CultureInfo.InvariantCulture));
			}
			else
			{
				writer.Write(reader.ReadDouble().ToString(CultureInfo.InvariantCulture));
			}
			break;
		case MessagePackType.String:
			WriteJsonString(reader.ReadString(), writer);
			break;
		case MessagePackType.Binary:
		{
			ArraySegment<byte> arraySegment = ByteArraySegmentFormatter.Instance.Deserialize(ref reader, options);
			writer.Write("\"" + Convert.ToBase64String(arraySegment.Array, arraySegment.Offset, arraySegment.Count) + "\"");
			break;
		}
		case MessagePackType.Array:
		{
			int num2 = reader.ReadArrayHeader();
			options.Security.DepthStep(ref reader);
			try
			{
				writer.Write("[");
				for (int j = 0; j < num2; j++)
				{
					ToJsonCore(ref reader, writer, options);
					if (j != num2 - 1)
					{
						writer.Write(",");
					}
				}
				writer.Write("]");
				break;
			}
			finally
			{
				reader.Depth--;
			}
		}
		case MessagePackType.Map:
		{
			int num = reader.ReadMapHeader();
			options.Security.DepthStep(ref reader);
			try
			{
				writer.Write("{");
				for (int i = 0; i < num; i++)
				{
					MessagePackType nextMessagePackType = reader.NextMessagePackType;
					if (nextMessagePackType == MessagePackType.String || nextMessagePackType == MessagePackType.Binary)
					{
						ToJsonCore(ref reader, writer, options);
					}
					else
					{
						writer.Write("\"");
						ToJsonCore(ref reader, writer, options);
						writer.Write("\"");
					}
					writer.Write(":");
					ToJsonCore(ref reader, writer, options);
					if (i != num - 1)
					{
						writer.Write(",");
					}
				}
				writer.Write("}");
				break;
			}
			finally
			{
				reader.Depth--;
			}
		}
		case MessagePackType.Extension:
		{
			ExtensionHeader header = reader.ReadExtensionFormatHeader();
			if (header.TypeCode == -1)
			{
				DateTime dateTime = reader.ReadDateTime(header);
				writer.Write("\"");
				writer.Write(dateTime.ToString("o", CultureInfo.InvariantCulture));
				writer.Write("\"");
				break;
			}
			ReadOnlySequence<byte> sequence = reader.ReadRaw(header.Length);
			writer.Write("[");
			writer.Write(header.TypeCode);
			writer.Write(",");
			writer.Write("\"");
			writer.Write(Convert.ToBase64String(BuffersExtensions.ToArray(in sequence)));
			writer.Write("\"");
			writer.Write("]");
			break;
		}
		case MessagePackType.Nil:
			reader.Skip();
			writer.Write("null");
			break;
		default:
			throw new MessagePackSerializationException($"code is invalid. code: {reader.NextCode} format: {MessagePackCode.ToFormatName(reader.NextCode)}");
		}
	}

	private static void WriteJsonString(string value, TextWriter builder)
	{
		builder.Write('"');
		int length = value.Length;
		for (int i = 0; i < length; i++)
		{
			char c = value[i];
			switch (c)
			{
			case '"':
				builder.Write("\\\"");
				break;
			case '\\':
				builder.Write("\\\\");
				break;
			case '\b':
				builder.Write("\\b");
				break;
			case '\f':
				builder.Write("\\f");
				break;
			case '\n':
				builder.Write("\\n");
				break;
			case '\r':
				builder.Write("\\r");
				break;
			case '\t':
				builder.Write("\\t");
				break;
			default:
				builder.Write(c);
				break;
			}
		}
		builder.Write('"');
	}

	static MessagePackSerializer()
	{
		DefaultOptions = MessagePackSerializerOptions.Standard;
		LZ4CodecEncode = LZ4Codec.Encode;
		LZ4CodecDecode = LZ4Codec.Decode;
		Serializes = new ThreadsafeTypeKeyHashTable<CompiledMethods>(64);
		CreateCompiledMethods = (Type t) => new CompiledMethods(t);
	}

	public static void Serialize(Type type, ref MessagePackWriter writer, object obj, MessagePackSerializerOptions options = null)
	{
		GetOrAdd(type).Serialize_MessagePackWriter_T_Options(ref writer, obj, options);
	}

	public static void Serialize(Type type, IBufferWriter<byte> writer, object obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		GetOrAdd(type).Serialize_IBufferWriter_T_Options_CancellationToken(writer, obj, options, cancellationToken);
	}

	public static byte[] Serialize(Type type, object obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).Serialize_T_Options(obj, options, cancellationToken);
	}

	public static void Serialize(Type type, Stream stream, object obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		GetOrAdd(type).Serialize_Stream_T_Options_CancellationToken(stream, obj, options, cancellationToken);
	}

	public static Task SerializeAsync(Type type, Stream stream, object obj, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).SerializeAsync_Stream_T_Options_CancellationToken(stream, obj, options, cancellationToken);
	}

	public static object Deserialize(Type type, ref MessagePackReader reader, MessagePackSerializerOptions options = null)
	{
		return GetOrAdd(type).Deserialize_MessagePackReader_Options(ref reader, options);
	}

	public static object Deserialize(Type type, Stream stream, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).Deserialize_Stream_Options_CancellationToken(stream, options, cancellationToken);
	}

	public static ValueTask<object> DeserializeAsync(Type type, Stream stream, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).DeserializeAsync_Stream_Options_CancellationToken(stream, options, cancellationToken);
	}

	public static object Deserialize(Type type, ReadOnlyMemory<byte> bytes, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).Deserialize_ReadOnlyMemory_Options(bytes, options, cancellationToken);
	}

	public static object Deserialize(Type type, ReadOnlySequence<byte> bytes, MessagePackSerializerOptions options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		return GetOrAdd(type).Deserialize_ReadOnlySequence_Options_CancellationToken(bytes, options, cancellationToken);
	}

	private static async ValueTask<object> DeserializeObjectAsync<T>(Stream stream, MessagePackSerializerOptions options, CancellationToken cancellationToken)
	{
		return await DeserializeAsync<T>(stream, options, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
	}

	private static CompiledMethods GetOrAdd(Type type)
	{
		return Serializes.GetOrAdd(type, CreateCompiledMethods);
	}
}

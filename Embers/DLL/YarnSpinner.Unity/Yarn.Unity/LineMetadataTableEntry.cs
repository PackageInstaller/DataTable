using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using CsvHelper;
using CsvHelper.Configuration;

namespace Yarn.Unity;

internal struct LineMetadataTableEntry(LineMetadataTableEntry s)
{
	public string ID = s.ID;

	public string File = s.File;

	public string Node = s.Node;

	public string LineNumber = s.LineNumber;

	public string[] Metadata = s.Metadata;

	private static Configuration CsvConfiguration;

	private static Configuration GetConfiguration()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Expected O, but got Unknown
		if (CsvConfiguration == null)
		{
			CsvConfiguration = new Configuration(CultureInfo.InvariantCulture)
			{
				MemberTypes = (MemberTypes)2
			};
		}
		return CsvConfiguration;
	}

	internal static IEnumerable<LineMetadataTableEntry> ParseFromCSV(string sourceText)
	{
		//IL_0115: Expected O, but got Unknown
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Expected O, but got Unknown
		try
		{
			using StringReader stringReader = new StringReader(sourceText);
			CsvReader val = new CsvReader((TextReader)stringReader, GetConfiguration());
			try
			{
				List<LineMetadataTableEntry> list = new List<LineMetadataTableEntry>();
				val.Read();
				val.ReadHeader();
				string text = default(string);
				string text2 = default(string);
				string text3 = default(string);
				string text4 = default(string);
				string text5 = default(string);
				while (val.Read())
				{
					val.TryGetField<string>("id", ref text);
					val.TryGetField<string>("file", ref text2);
					val.TryGetField<string>("node", ref text3);
					val.TryGetField<string>("lineNumber", ref text4);
					val.TryGetField<string>("metadata", ref text5);
					LineMetadataTableEntry item = new LineMetadataTableEntry
					{
						ID = (text ?? string.Empty),
						File = (text2 ?? string.Empty),
						Node = (text3 ?? string.Empty),
						LineNumber = (text4 ?? string.Empty),
						Metadata = (text5?.Split(' ') ?? new string[0])
					};
					list.Add(item);
				}
				return list;
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
		}
		catch (CsvHelperException ex)
		{
			CsvHelperException arg = ex;
			throw new ArgumentException($"Error reading CSV file: {arg}");
		}
	}

	public static string CreateCSV(IEnumerable<LineMetadataTableEntry> entries)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Expected O, but got Unknown
		using StringWriter stringWriter = new StringWriter();
		CsvWriter val = new CsvWriter((TextWriter)stringWriter, GetConfiguration());
		string[] array = new string[5] { "id", "file", "node", "lineNumber", "metadata" };
		foreach (string text in array)
		{
			val.WriteField(text);
		}
		val.NextRecord();
		foreach (LineMetadataTableEntry entry in entries)
		{
			array = new string[5]
			{
				entry.ID,
				entry.File,
				entry.Node,
				entry.LineNumber,
				string.Join(" ", entry.Metadata)
			};
			foreach (string text2 in array)
			{
				val.WriteField(text2);
			}
			val.NextRecord();
		}
		return stringWriter.ToString();
	}

	public override string ToString()
	{
		return "LineMetadataTableEntry: id=" + ID + " file=" + File + " node=" + Node + " line=" + LineNumber + " metadata=" + string.Join(" ", Metadata);
	}

	public override bool Equals(object obj)
	{
		if (obj is LineMetadataTableEntry lineMetadataTableEntry && ID == lineMetadataTableEntry.ID && File == lineMetadataTableEntry.File && Node == lineMetadataTableEntry.Node && LineNumber == lineMetadataTableEntry.LineNumber)
		{
			return Enumerable.SequenceEqual(Metadata, lineMetadataTableEntry.Metadata);
		}
		return false;
	}

	public override int GetHashCode()
	{
		int num = ID.GetHashCode() ^ File.GetHashCode() ^ Node.GetHashCode() ^ LineNumber.GetHashCode();
		string[] metadata = Metadata;
		foreach (string text in metadata)
		{
			num ^= text.GetHashCode();
		}
		return num;
	}
}

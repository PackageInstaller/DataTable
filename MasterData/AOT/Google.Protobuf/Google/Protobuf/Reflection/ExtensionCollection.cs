using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace Google.Protobuf.Reflection;

public sealed class ExtensionCollection
{
	private IDictionary<MessageDescriptor, IList<FieldDescriptor>> extensionsByTypeInDeclarationOrder;

	private IDictionary<MessageDescriptor, IList<FieldDescriptor>> extensionsByTypeInNumberOrder;

	public IList<FieldDescriptor> UnorderedExtensions { get; }

	internal ExtensionCollection(FileDescriptor file, Extension[] extensions)
	{
		UnorderedExtensions = DescriptorUtil.ConvertAndMakeReadOnly(file.Proto.Extension, (FieldDescriptorProto extension, int i) =>
		{
			Extension[] array = extensions;
			if (array == null || array.Length != 0)
			{
				FileDescriptor file2 = file;
				Extension[] array2 = extensions;
				return new FieldDescriptor(extension, file2, null, i, null, (array2 != null) ? array2[i] : null);
			}
			return new FieldDescriptor(extension, file, null, i, null, null);
		});
	}

	internal ExtensionCollection(MessageDescriptor message, Extension[] extensions)
	{
		UnorderedExtensions = DescriptorUtil.ConvertAndMakeReadOnly(message.Proto.Extension, (FieldDescriptorProto extension, int i) =>
		{
			Extension[] array = extensions;
			if (array == null || array.Length != 0)
			{
				FileDescriptor file = message.File;
				MessageDescriptor parent = message;
				Extension[] array2 = extensions;
				return new FieldDescriptor(extension, file, parent, i, null, (array2 != null) ? array2[i] : null);
			}
			return new FieldDescriptor(extension, message.File, message, i, null, null);
		});
	}

	internal void CrossLink()
	{
		Dictionary<MessageDescriptor, IList<FieldDescriptor>> dictionary = new Dictionary<MessageDescriptor, IList<FieldDescriptor>>();
		foreach (FieldDescriptor unorderedExtension in UnorderedExtensions)
		{
			unorderedExtension.CrossLink();
			if (!dictionary.TryGetValue(unorderedExtension.ExtendeeType, out var value))
			{
				value = new List<FieldDescriptor>();
				dictionary.Add(unorderedExtension.ExtendeeType, value);
			}
			value.Add(unorderedExtension);
		}
		extensionsByTypeInDeclarationOrder = ((IEnumerable<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>>)dictionary).ToDictionary((Func<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>, MessageDescriptor>)((KeyValuePair<MessageDescriptor, IList<FieldDescriptor>> kvp) => kvp.Key), (Func<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>, IList<FieldDescriptor>>)((KeyValuePair<MessageDescriptor, IList<FieldDescriptor>> kvp) => new ReadOnlyCollection<FieldDescriptor>(kvp.Value)));
		extensionsByTypeInNumberOrder = ((IEnumerable<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>>)dictionary).ToDictionary((Func<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>, MessageDescriptor>)((KeyValuePair<MessageDescriptor, IList<FieldDescriptor>> kvp) => kvp.Key), (Func<KeyValuePair<MessageDescriptor, IList<FieldDescriptor>>, IList<FieldDescriptor>>)((KeyValuePair<MessageDescriptor, IList<FieldDescriptor>> kvp) => new ReadOnlyCollection<FieldDescriptor>(kvp.Value.OrderBy((FieldDescriptor field) => field.FieldNumber).ToArray())));
	}
}

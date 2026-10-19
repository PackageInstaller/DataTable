using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Google.Protobuf.Reflection;

public sealed class DescriptorDeclaration
{
	[CompilerGenerated]
	private readonly IDescriptor Descriptor__BackingField;

	[CompilerGenerated]
	private readonly int StartColumn__BackingField;

	[CompilerGenerated]
	private readonly int EndLine__BackingField;

	[CompilerGenerated]
	private readonly int EndColumn__BackingField;

	[CompilerGenerated]
	private readonly string LeadingComments__BackingField;

	[CompilerGenerated]
	private readonly string TrailingComments__BackingField;

	[CompilerGenerated]
	private readonly IReadOnlyList<string> LeadingDetachedComments__BackingField;

	public int StartLine { get; }

	private DescriptorDeclaration(IDescriptor descriptor, SourceCodeInfo.Types.Location location)
	{
		Descriptor__BackingField = descriptor;
		bool flag = location.Span.Count == 4;
		StartLine = location.Span[0] + 1;
		StartColumn__BackingField = location.Span[1] + 1;
		EndLine__BackingField = (flag ? (location.Span[2] + 1) : StartLine);
		EndColumn__BackingField = location.Span[flag ? 3 : 2] + 1;
		LeadingComments__BackingField = location.LeadingComments;
		TrailingComments__BackingField = location.TrailingComments;
		LeadingDetachedComments__BackingField = new ReadOnlyCollection<string>(location.LeadingDetachedComments.ToList());
	}

	internal static DescriptorDeclaration FromProto(IDescriptor descriptor, SourceCodeInfo.Types.Location location)
	{
		return new DescriptorDeclaration(descriptor, location);
	}
}

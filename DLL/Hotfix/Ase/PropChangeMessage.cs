using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class PropChangeMessage : MessageBase
{
	private PropChangeMessageEnum type;

	private List<KnapsackPropData> propsChanged = new List<KnapsackPropData>();

	public PropChangeMessageEnum Type => type;

	public List<KnapsackPropData> PropsChanged => propsChanged;

	public PropChangeMessage(object sender, PropChangeMessageEnum type, List<KnapsackPropData> propsChanged)
		: base(sender)
	{
		this.type = type;
		this.propsChanged = propsChanged;
	}
}

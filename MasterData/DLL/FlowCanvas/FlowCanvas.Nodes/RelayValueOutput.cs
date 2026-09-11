using System.Linq;
using MessagePack;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class RelayValueOutput<T> : RelayValueOutputBase
{
	[SerializeField]
	private string _sourceInputUID;

	private object _sourceInput;

	private string sourceInputUID
	{
		get
		{
			return _sourceInputUID;
		}
		set
		{
			_sourceInputUID = value;
		}
	}

	private RelayValueInput<T> sourceInput
	{
		get
		{
			if (_sourceInput == null)
			{
				_sourceInput = base.graph.GetAllNodesOfType<RelayValueInput<T>>().FirstOrDefault((RelayValueInput<T> i) => i.UID == sourceInputUID);
				if (_sourceInput == null)
				{
					_sourceInput = new object();
				}
			}
			return _sourceInput as RelayValueInput<T>;
		}
		set
		{
			_sourceInput = value;
		}
	}

	public override string name => string.Format("{0}", (sourceInput != null) ? sourceInput.ToString() : "@ NONE");

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_sourceInputUID);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_sourceInputUID = reader.ReadString();
	}

	public override void SetSource(RelayValueInputBase source)
	{
		_sourceInputUID = source?.UID;
		_sourceInput = ((source != null) ? source : null);
		GatherPorts();
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("Value", () => (sourceInput == null) ? default(T) : sourceInput.port.value);
	}
}

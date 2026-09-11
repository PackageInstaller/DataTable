using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Macros;

[DoNotList]
[Color("ffe4e1")]
public class MacroNodeWrapper : FlowNode, IGraphAssignable, IUpdatable
{
	[SerializeField]
	private Macro _macro;

	private bool instantiated;

	public override string name
	{
		get
		{
			if (!(macro != null))
			{
				return "No Macro";
			}
			return macro.name;
		}
	}

	public override string description
	{
		get
		{
			if (!(_macro != null) || string.IsNullOrEmpty(_macro.comments))
			{
				return base.description;
			}
			return _macro.comments;
		}
	}

	public Macro macro
	{
		get
		{
			return _macro;
		}
		set
		{
			if (_macro != value)
			{
				_macro = value;
				if (value != null)
				{
					GatherPorts();
				}
			}
		}
	}

	Graph IGraphAssignable.nestedGraph
	{
		get
		{
			return macro;
		}
		set
		{
			macro = (Macro)value;
		}
	}

	Graph[] IGraphAssignable.GetInstances()
	{
		if (!instantiated)
		{
			return new Graph[0];
		}
		return new Graph[1] { _macro };
	}

	public void CheckInstance()
	{
		if (!(macro == null) && !instantiated)
		{
			instantiated = true;
			macro = Graph.Clone(macro);
		}
	}

	void IUpdatable.Update()
	{
		if (!(macro == null) && instantiated)
		{
			macro.UpdateGraph();
		}
	}

	protected override void RegisterPorts()
	{
		if (macro == null)
		{
			return;
		}
		for (int i = 0; i < macro.inputDefinitions.Count; i++)
		{
			DynamicPortDefinition defIn = macro.inputDefinitions[i];
			if (defIn.type == typeof(Flow))
			{
				AddFlowInput(defIn.name, delegate(Flow f)
				{
					macro.entryActionMap[defIn.ID](f);
				}, defIn.ID);
			}
			else
			{
				macro.entryFunctionMap[defIn.ID] = AddValueInput(defIn.name, defIn.type, defIn.ID).GetObjectValue;
			}
		}
		for (int num = 0; num < macro.outputDefinitions.Count; num++)
		{
			DynamicPortDefinition defOut = macro.outputDefinitions[num];
			if (defOut.type == typeof(Flow))
			{
				macro.exitActionMap[defOut.ID] = AddFlowOutput(defOut.name, defOut.ID).Call;
				continue;
			}
			AddValueOutput(defOut.name, defOut.type, () => macro.exitFunctionMap[defOut.ID](), defOut.ID);
		}
	}
}

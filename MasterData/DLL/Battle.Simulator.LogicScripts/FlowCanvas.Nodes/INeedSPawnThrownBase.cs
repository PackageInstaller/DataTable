namespace FlowCanvas.Nodes;

public abstract class INeedSPawnThrownBase : FlowControlNode
{
	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_thrownID;

	protected override void RegisterPorts()
	{
		AddValueInput();
		AddBaseFlowOutput();
		AddCustomFlowOutput();
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!TryGetAttributeID(base.mSimContext, GetAttributeID(), GetProducerID(), out var _) || !ConditionFunc())
			{
				ErrorFunc();
				m_error.Call(f);
			}
			else
			{
				m_thrownID = ThrownProcessor.SpawnThrown(base.mSimContext, GetCasterID(), 0, 0, GetPositionID(), GetForwardID(), GetThrownTimelineID(), useCommon: true, GetProducerID(), GetCreatedRootTimelineID(), GetAttributeID(), out var _);
				OutFunc();
				m_out.Call(f);
			}
		});
		AddBaseValueOutput();
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}

	private void AddBaseFlowOutput()
	{
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
	}

	public bool TryGetAttributeID(SimContext mSimContext, int attributeIDInput, int creationIndex, out int attributeID)
	{
		attributeID = attributeIDInput;
		if (attributeID != 0)
		{
			return true;
		}
		if (creationIndex < 0)
		{
			if (ThrownProcessor.TryGetThrown(mSimContext, creationIndex, out var thrownState))
			{
				attributeID = thrownState.mAttributeID;
				return true;
			}
		}
		else if (creationIndex > 0)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(creationIndex);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				attributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
				return true;
			}
		}
		return false;
	}

	protected abstract int GetCasterID();

	protected abstract int GetThrownTimelineID();

	protected abstract Int3 GetPositionID();

	protected abstract Int3 GetForwardID();

	protected abstract int GetProducerID();

	protected abstract int GetCreatedRootTimelineID();

	protected abstract int GetAttributeID();

	protected abstract void AddValueInput();

	protected abstract bool ConditionFunc();

	protected virtual void AddCustomFlowOutput()
	{
	}

	protected virtual void ErrorFunc()
	{
	}

	protected virtual void OutFunc()
	{
	}
}

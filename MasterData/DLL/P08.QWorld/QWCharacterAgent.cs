using UnityEngine;

[RequireComponent(typeof(QWCharacterBlackboard))]
public class QWCharacterAgent : QWAgent
{
	private Vector3 lastFramePosition = Vector3.zero;

	public float inerationRadius = 1f;

	private LayerMask interactionLayerMask;

	public QWCharacterBlackboard CharacterBlackboard => base.Blackboard as QWCharacterBlackboard;

	public override QWAgentLayer GetAgentLayer()
	{
		return QWAgentLayer.Player;
	}

	private void Awake()
	{
		interactionLayerMask = LayerMask.GetMask("Default");
	}

	public override void Initialize()
	{
		if (_blackboard == null)
		{
			_blackboard = GetComponent<IQWBlackboard>();
			_blackboard.InitBlackboard();
		}
		CharacterBlackboard.characterCommonBehaviour.InitialCharacter(QWorldScene.Scene.initialCharId, CharacterBlackboard, this);
		base.Initialize();
		CharacterBlackboard.locomotionBehaviour.OnRushStateChanged = OnRushStateChange;
		CharacterBlackboard.locomotionBehaviour.OnRushChanged = OnRushStateChange;
	}

	public bool GetIsUseGamePad()
	{
		return CharacterBlackboard.inputMovement.UseGamePad;
	}

	public bool GetIsInRush()
	{
		return CharacterBlackboard.locomotionBehaviour.IsInRush;
	}

	public bool GetIsInFastRush()
	{
		return CharacterBlackboard.locomotionBehaviour.IsInFastRush;
	}

	public void ChangeRush()
	{
		QWCharacterRushAction qWCharacterRushAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeRush) as QWCharacterRushAction;
		qWCharacterRushAction.isRush = !GetIsInRush();
		base.Blackboard.ActionAdd(qWCharacterRushAction);
	}

	public void ChangeFastRush()
	{
		QWCharacterFastRushAction qWCharacterFastRushAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeFastRush) as QWCharacterFastRushAction;
		qWCharacterFastRushAction.isFastRush = !GetIsInFastRush();
		base.Blackboard.ActionAdd(qWCharacterFastRushAction);
	}

	private void OnRushStateChange()
	{
		(NScene.GetCurrentScene() as QWorldScene)?.mWorldUI?.ChangeDoggleState(GetIsInRush(), GetIsInFastRush());
	}

	public void HideAgent()
	{
	}
}

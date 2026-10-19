using ACT.Utility;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigLaserObject : LuminSerializedScriptableObject
{
	[SerializeField]
	private LayerMask _layerMask = BattleConsts.enviromentMask;

	[SerializeField]
	private float _maxLength = 20f;

	[SerializeField]
	private float _radius = 0.5f;

	[SerializeField]
	private AllianceCondition _alliance;

	[SerializeField]
	private FilterEntityType _filterEntityType = GameUtility.defaultFilterEntityType;

	[SerializeField]
	private FilterCantBeAttackType _filterCantBeAttackType;

	[SerializeField]
	private bool _canBeAttack;

	[SerializeField]
	private ConfigAction[] _onTriggerEnter;

	[SerializeField]
	private ConfigAction[] _onTriggerStay;

	[SerializeField]
	private ConfigAction[] _onTriggerExit;

	[SerializeField]
	private AnimationCurve _showCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	[SerializeField]
	private AnimationCurve _hideCurve = AnimationCurve.EaseInOut(0f, 1f, 1f, 0f);

	[SerializeField]
	private float _animDuration = 0.5f;

	public LayerMask LayerMask => _layerMask;

	public float MaxLength => _maxLength;

	public float Radius => _radius;

	public AllianceCondition Alliance => _alliance;

	public FilterEntityType FilterEntityType => _filterEntityType;

	private FilterCantBeAttackType FilterCantBeAttackType => _filterCantBeAttackType;

	public bool CanBeAttack => _canBeAttack;

	public ConfigAction[] OnTriggerEnter => _onTriggerEnter;

	public ConfigAction[] OnTriggerStay => _onTriggerStay;

	public ConfigAction[] OnTriggerExit => _onTriggerExit;

	public AnimationCurve ShowCurve => _showCurve;

	public AnimationCurve HideCurve => _hideCurve;

	public float AnimDuration => _animDuration;
}

using Animancer;
using UnityEngine;

namespace T0World;

[CreateAssetMenu(menuName = "Asset/MoveAniData")]
public class MoveAniData : ScriptableObject
{
	public TransitionAsset moveStartForward;

	public TransitionAsset moveStartTurning;

	public TransitionAsset moveLoop;

	public TransitionAsset moveEnd;

	public TransitionAsset moveEndAdjustDir;

	public TransitionAsset idle;

	public StringAsset rotationValueParameter;

	public StringAsset speedValueParameter;
}

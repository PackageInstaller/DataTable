using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Serialization;

namespace ACT.Battle;

[DisallowMultipleComponent]
public class MonoEntityConfig : MonoBehaviour
{
	public SonCollider[] sonColliders;

	public AttachPoint[] attachPoints;

	public MonoBodyPart[] bodyParts;

	public GameObject[] shadowColliders;

	public WeaponPart[] weaponParts;

	public MixedPart[] MixedParts;

	public AniPartControl aniControl;

	public LineRenderPart[] lineRenderParts;

	public Transform[] switchSkillPoints;

	public BodyPartPriorityHitEffect[] priorityHitEffect;

	public MonoMagicaCloth monoMagicaCloth;

	public MaterialOverride materialOverride;

	public ActBehaviorTree btree;

	public NavMeshAgent agent;

	[FormerlySerializedAs("weapon1")]
	public WeaponPartAttach[] weaponAttachs;

	public Renderer[] renderers;

	public void ApplyTo(MonoEntity target)
	{
		if (!(target == null))
		{
			target.sonColliders = sonColliders;
			target.attachPoints = attachPoints;
			target.bodyParts = bodyParts;
			target.weaponParts = weaponParts;
			target.MixedParts = MixedParts;
			target.aniControl = aniControl;
			target.lineRenderParts = lineRenderParts;
			target.switchSkillPoints = switchSkillPoints;
			target.priorityHitEffect = priorityHitEffect;
			target.monoMagicaCloth = monoMagicaCloth;
			target.materialOverride = materialOverride;
			target.btree = btree;
			target.agent = agent;
			target.weaponAttachs = weaponAttachs;
			target.renderers = renderers;
		}
	}

	public void SetRenderLayerToCharacterUIScene()
	{
		if (renderers == null)
		{
			return;
		}
		Renderer[] array = renderers;
		foreach (Renderer renderer in array)
		{
			if ((bool)renderer)
			{
				renderer.gameObject.layer = 22;
			}
		}
	}
}

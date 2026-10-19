using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SetMeshRenderDither : InteractAction
{
	public MeshRenderer meshRenderer;

	public BoxCollider box;

	public GameObject damageBox;

	public float time;

	private bool m_IsStart;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		m_IsStart = true;
		return UniTask.CompletedTask;
	}

	private void Update()
	{
		if (m_IsStart)
		{
			time -= Time.deltaTime;
			meshRenderer.material.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, time);
			if (time < 0f)
			{
				time = 0f;
				box.enabled = false;
				damageBox.SetActive(value: false);
				m_IsStart = false;
			}
		}
	}
}

using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("创建SpotLightDrone", "Action", new string[] { "create", "spot", "light", "drone" })]
public class ActionCreateSpotLightDrone : ConfigAction
{
	public ConfigFunction<Vector3> pos;

	public ActionCreatFlexibleEntity bullet;

	public float radius = 1f;

	public float height = 10f;

	private Vector3 m_Position;

	private Quaternion m_Rotation;

	public override void Do(ActionMemory memory)
	{
		m_Position = pos.Return(memory);
		m_Rotation = Quaternion.LookRotation(new Vector3(0f, -1f, 0f));
		bullet.type = AbilityEntityType.SpotLightDrone;
		MonoECS.instance.SpawnFlexibleEntity(bullet.GetParams(m_Position, m_Rotation), memory.owner, memory.ability, OnCreate);
	}

	private void OnCreate(Entity entityBehave)
	{
		GameManager.entities.factory.AttachSpotLightComp(entityBehave);
		CompSpotLightBuffer? compSpotLightBuffer = entityBehave.GetCompSpotLightBuffer();
		compSpotLightBuffer.pos = m_Position;
		compSpotLightBuffer.radius = radius;
		compSpotLightBuffer.height = height;
	}
}

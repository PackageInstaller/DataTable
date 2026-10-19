using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Rendering;

public sealed class CharacterHDShadowManager : GameSubManager
{
	private const int MaxEnabledShadowCount = 4;

	private readonly List<CharacterHDShadow> m_RegisteredShadows = new List<CharacterHDShadow>();

	private GameRenderScene.Scene m_CurrentScene;

	private Transform m_MainEntityModelTransform;

	public override ContextType ContextType => ContextType.GAME;

	protected override void Init()
	{
		m_CurrentScene = GameRenderScene.Current;
		RefreshAllShadows();
	}

	protected override void UnInit()
	{
		for (int num = m_RegisteredShadows.Count - 1; num >= 0; num--)
		{
			CharacterHDShadow characterHDShadow = m_RegisteredShadows[num];
			if (characterHDShadow != null)
			{
				characterHDShadow.SetHDShadowEnabled(enabled: false);
			}
		}
		m_MainEntityModelTransform = null;
	}

	protected override void Update()
	{
		if (m_CurrentScene == GameRenderScene.Scene.UltraCutscene && m_MainEntityModelTransform != GetMainEntityModelTransform())
		{
			RefreshAllShadows();
		}
	}

	public void Register(CharacterHDShadow shadow)
	{
		if (!(shadow == null))
		{
			if (!m_RegisteredShadows.Contains(shadow))
			{
				m_RegisteredShadows.Add(shadow);
			}
			RefreshAllShadows();
		}
	}

	public void Unregister(CharacterHDShadow shadow)
	{
		if (!(shadow == null))
		{
			m_RegisteredShadows.Remove(shadow);
			shadow.SetHDShadowEnabled(enabled: false);
			RefreshAllShadows();
		}
	}

	internal void Refresh()
	{
		RefreshAllShadows();
	}

	public void SetScene(GameRenderScene.Scene scene)
	{
		if (m_CurrentScene != scene)
		{
			m_CurrentScene = scene;
			RefreshAllShadows();
		}
	}

	private void RefreshAllShadows()
	{
		RemoveInvalidShadows();
		m_MainEntityModelTransform = GetMainEntityModelTransform();
		for (int i = 0; i < m_RegisteredShadows.Count; i++)
		{
			m_RegisteredShadows[i].SetHDShadowEnabled(enabled: false);
		}
		int num = 0;
		for (int j = 0; j < m_RegisteredShadows.Count; j++)
		{
			CharacterHDShadow characterHDShadow = m_RegisteredShadows[j];
			if (num < 4 && ShouldEnable(characterHDShadow) && characterHDShadow.SetHDShadowEnabled(enabled: true))
			{
				num++;
			}
		}
	}

	private void RemoveInvalidShadows()
	{
		for (int num = m_RegisteredShadows.Count - 1; num >= 0; num--)
		{
			if (m_RegisteredShadows[num] == null)
			{
				m_RegisteredShadows.RemoveAt(num);
			}
		}
	}

	private bool ShouldEnable(CharacterHDShadow shadow)
	{
		if (m_CurrentScene == GameRenderScene.Scene.MainBattle)
		{
			if (shadow.ObjectType == CharacterHDShadowObjectType.UnBattle)
			{
				return shadow.UseCharacterMainLight;
			}
			return false;
		}
		if (m_CurrentScene == GameRenderScene.Scene.TimelineConversation)
		{
			return shadow.ObjectType == CharacterHDShadowObjectType.UnBattle;
		}
		if (m_CurrentScene == GameRenderScene.Scene.UltraCutscene)
		{
			if (shadow.ObjectType == CharacterHDShadowObjectType.Battle)
			{
				return IsMainEntity(shadow);
			}
			return false;
		}
		if (m_CurrentScene == GameRenderScene.Scene.CharacterTeam || m_CurrentScene == GameRenderScene.Scene.AVG || m_CurrentScene == GameRenderScene.Scene.Room || m_CurrentScene == GameRenderScene.Scene.CardDraw || m_CurrentScene == GameRenderScene.Scene.CreateCharacter)
		{
			return shadow.ObjectType == CharacterHDShadowObjectType.UnBattle;
		}
		return false;
	}

	private bool IsMainEntity(CharacterHDShadow shadow)
	{
		if (m_MainEntityModelTransform == null)
		{
			return false;
		}
		Transform transform = shadow.transform;
		if (!(transform == m_MainEntityModelTransform) && !transform.IsChildOf(m_MainEntityModelTransform))
		{
			return m_MainEntityModelTransform.IsChildOf(transform);
		}
		return true;
	}

	private static Transform GetMainEntityModelTransform()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null || !instance.mainEntity.IsValid)
		{
			return null;
		}
		GameObject model = instance.mainEntity.GetModel();
		if (!(model != null))
		{
			return null;
		}
		return model.transform;
	}
}

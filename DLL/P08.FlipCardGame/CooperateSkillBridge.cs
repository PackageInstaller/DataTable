using UnityEngine;
using UnityEngine.Playables;

public class CooperateSkillBridge
{
	public static void Launcher()
	{
		NScene.Load<CooperateSkillSceneLoader>();
	}

	public static void StartZumaGame()
	{
		NScene.GetCurrentScene();
	}

	public static GameObject PlayCooperateUniqueSkill(string skinID, string name, out double length)
	{
		GameObject gameObject = Object.Instantiate(Asset.Load("CooperateUniqueSkillTimeline/" + name)) as GameObject;
		EffectController[] componentsInChildren = gameObject.GetComponentsInChildren<EffectController>();
		EffectController[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(active: true);
		}
		gameObject.SetActive(value: false);
		array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].EnableVirtualCameras();
		}
		PlayableDirector componentInChildren = gameObject.GetComponentInChildren<PlayableDirector>();
		componentInChildren.time = 0.0;
		length = componentInChildren.duration;
		gameObject.SetActive(value: true);
		componentInChildren.Play();
		return gameObject;
	}
}

using System;
using UnityEngine;
using UnityEngine.U2D;

public class AtlasHelper : MonoBehaviour
{
	public static Action<SpriteAtlas> atlasLoadAction;

	public float gcTick = 1f;

	public float curTick;

	private void Awake()
	{
		SpriteAtlasManager.atlasRequested += OnAtlasRequsted;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}

	private void Update()
	{
		curTick += Time.deltaTime;
		if (curTick > gcTick)
		{
			curTick = 0f;
			AtlasManager.GCSprites();
		}
	}

	private void OnAtlasRequsted(string tag, Action<SpriteAtlas> action)
	{
		Debug.Log("!!!!!!!!!!! OnAtlasRequsted: Atlas/" + tag);
		SpriteAtlas spriteAtlas = Asset.Load<SpriteAtlas>("Atlas/" + tag);
		if (spriteAtlas == null)
		{
			Debug.LogError("!!!!!!!!!!! OnAtlasRequsted: Atlas/" + tag + " is not exist!!!");
			return;
		}
		action(spriteAtlas);
		if (atlasLoadAction == null)
		{
			atlasLoadAction = action;
		}
	}
}

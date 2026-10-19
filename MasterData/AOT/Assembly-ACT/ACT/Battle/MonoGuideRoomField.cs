using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class MonoGuideRoomField : MonoBehaviour
{
	public GameObject[] objs;

	public int m_Count;

	private bool m_isPlay;

	private Dictionary<uint, MonoEntity> m_infos = new Dictionary<uint, MonoEntity>();

	public void Hide()
	{
		CheckCount();
		if (m_Count != 0)
		{
			return;
		}
		for (int i = 0; i < objs.Length; i++)
		{
			if (objs[i] != null)
			{
				OnTriggerExitTask(objs[i]).Forget();
			}
		}
	}

	public async void Show()
	{
		CheckCount();
		for (int i = 0; i < objs.Length; i++)
		{
			if (objs[i] != null)
			{
				await UniTask.WaitUntil(() => !m_isPlay);
				Animation animation = objs[i].GetComponent<Animation>();
				m_isPlay = true;
				if (animation != null)
				{
					animation.Play();
				}
				await UniTask.Delay((int)(animation.clip.length * 1000f));
				if (animation != null)
				{
					animation.Stop();
				}
				m_isPlay = false;
			}
		}
	}

	private async UniTaskVoid OnTriggerExitTask(GameObject go)
	{
		CancellationToken token = go.GetCancellationTokenOnDestroy();
		await UniTask.WaitUntil(() => !m_isPlay, PlayerLoopTiming.Update, token);
		if (token.IsCancellationRequested)
		{
			return;
		}
		Animation animation = go.GetComponent<Animation>();
		AnimationState animationState = animation[animation.clip.name];
		animationState.time = animationState.length;
		animationState.speed = -1f;
		m_isPlay = true;
		if (animation != null)
		{
			animation.Play();
		}
		await UniTask.Delay((int)(animationState.length * 1000f), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		if (!token.IsCancellationRequested)
		{
			if (animation != null)
			{
				animationState.speed = 1f;
				animation.Stop();
			}
			m_isPlay = false;
		}
	}

	private void CheckCount()
	{
		int num = 0;
		foreach (KeyValuePair<uint, MonoEntity> info in m_infos)
		{
			if (info.Value.isActiveAndEnabled)
			{
				num++;
			}
		}
		m_Count = num;
	}
}

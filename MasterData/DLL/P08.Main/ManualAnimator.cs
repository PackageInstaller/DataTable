using System.Collections;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

public class ManualAnimator : MonoBehaviour
{
	private PlayableGraph m_graph;

	private AnimationPlayableOutput m_output;

	private AnimationMixerPlayable m_mixRoot;

	private int currentClipIndex = -1;

	private int currentHashCode;

	private double _lastSpeed = 1.0;

	private bool _isBlending;

	private const double SENSELESS_WEIGHT = 0.005;

	private void Awake()
	{
		m_graph = PlayableGraph.Create("ManualAnimator" + base.gameObject.name + base.gameObject.GetInstanceID());
		AnimationPlayableOutput output = AnimationPlayableOutput.Create(m_graph, "AnimationOutput", GetComponent<Animator>());
		m_mixRoot = AnimationMixerPlayable.Create(m_graph, 2);
		output.SetSourcePlayable(m_mixRoot);
		m_output = output;
	}

	private void OnEnable()
	{
		m_graph.Play();
	}

	private void OnDisable()
	{
		_isBlending = false;
		StopAllCoroutines();
		for (int i = 0; i < 2; i++)
		{
			Playable input = m_mixRoot.GetInput(i);
			if (!input.IsNull())
			{
				DestoryPlayable(input);
				m_mixRoot.DisconnectInput(i);
			}
		}
		currentClipIndex = -1;
		currentHashCode = 0;
		m_graph.Stop();
	}

	private void DestoryPlayable(Playable playable)
	{
		if (!playable.IsNull())
		{
			int inputCount = playable.GetInputCount();
			for (int i = 0; i < inputCount; i++)
			{
				Playable input = playable.GetInput(i);
				DestoryPlayable(input);
			}
			m_graph.DestroyPlayable(playable);
		}
	}

	private void CullSenselessBlending(AnimationMixerPlayable mixer, double mixerWeight)
	{
		if (mixer.IsNull())
		{
			return;
		}
		int inputCount = mixer.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			Playable input = mixer.GetInput(i);
			if (!input.IsNull())
			{
				double num = mixerWeight * (double)mixer.GetInputWeight(i);
				if (num < 0.005)
				{
					DestoryPlayable(input);
					mixer.DisconnectInput(i);
				}
				else if (input.GetPlayableType() == typeof(AnimationMixerPlayable))
				{
					AnimationMixerPlayable mixer2 = (AnimationMixerPlayable)input;
					CullSenselessBlending(mixer2, num);
				}
			}
		}
	}

	public Playable Play(int hashCode, AnimationClip clip, double time, float blendTime = 0.3f, double speed = 1.0)
	{
		if (null == clip)
		{
			return Playable.Null;
		}
		if (!LuaForUtil.IsManualAnimatorBlend)
		{
			blendTime = 0f;
		}
		if (currentClipIndex == -1)
		{
			AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(m_graph, clip);
			animationClipPlayable.SetTime(time);
			animationClipPlayable.SetSpeed(0.0);
			m_mixRoot.ConnectInput(0, animationClipPlayable, 0);
			m_mixRoot.SetInputWeight(0, 1f);
			currentClipIndex = 0;
			currentHashCode = hashCode;
			_lastSpeed = speed;
			m_graph.Evaluate(0f);
			return animationClipPlayable;
		}
		if (hashCode == currentHashCode)
		{
			Playable input = m_mixRoot.GetInput(currentClipIndex);
			input.SetTime(time);
			return input;
		}
		int num = (_isBlending ? (1 - currentClipIndex) : currentClipIndex);
		int num2 = 1 - num;
		Playable input2 = m_mixRoot.GetInput(num2);
		Playable input3 = m_mixRoot.GetInput(num);
		if (!input2.IsNull())
		{
			if (_isBlending)
			{
				AnimationMixerPlayable animationMixerPlayable = AnimationMixerPlayable.Create(m_graph, 2);
				animationMixerPlayable.SetSpeed(0.0);
				float inputWeight = m_mixRoot.GetInputWeight(num2);
				float inputWeight2 = m_mixRoot.GetInputWeight(num);
				m_mixRoot.DisconnectInput(num);
				m_mixRoot.DisconnectInput(num2);
				m_graph.Connect(input2, 0, animationMixerPlayable, 0);
				m_graph.Connect(input3, 0, animationMixerPlayable, 1);
				animationMixerPlayable.SetInputWeight(0, inputWeight);
				animationMixerPlayable.SetInputWeight(1, inputWeight2);
				input2.SetSpeed(1.0);
				input3.SetSpeed(1.0);
				m_graph.Connect(animationMixerPlayable, 0, m_mixRoot, num);
				m_mixRoot.SetInputWeight(num, 1f);
				m_graph.Evaluate(0f);
				CullSenselessBlending(animationMixerPlayable, 1.0);
			}
			else
			{
				DestoryPlayable(input2);
				m_mixRoot.DisconnectInput(num2);
			}
		}
		AnimationClipPlayable animationClipPlayable2 = AnimationClipPlayable.Create(m_graph, clip);
		animationClipPlayable2.SetTime(time);
		animationClipPlayable2.SetSpeed(0.0);
		m_mixRoot.ConnectInput(num2, animationClipPlayable2, 0);
		if (!input3.IsNull())
		{
			StopAllCoroutines();
			StartCoroutine(CoroutineFunc(num2, num, blendTime, _lastSpeed));
		}
		else
		{
			m_mixRoot.SetInputWeight(num2, 1f);
			m_mixRoot.SetInputWeight(num, 0f);
		}
		currentHashCode = hashCode;
		currentClipIndex = num2;
		_lastSpeed = speed;
		return animationClipPlayable2;
	}

	public void Stop(int hashCode, AnimationClip clip)
	{
		_ = currentHashCode;
	}

	private IEnumerator CoroutineFunc(int index, int lastIndex, float duration, double lastSpeed)
	{
		Playable lastPlayable = m_mixRoot.GetInput(lastIndex);
		bool hasLastPlayable = !lastPlayable.IsNull();
		m_mixRoot.SetInputWeight(index, 0f);
		m_mixRoot.SetInputWeight(lastIndex, 1f);
		_isBlending = true;
		float timer = 0f;
		while (timer < duration)
		{
			float num = Mathf.Clamp01(timer / duration);
			timer += Time.deltaTime;
			m_mixRoot.SetInputWeight(index, num);
			m_mixRoot.SetInputWeight(lastIndex, 1f - num);
			if (hasLastPlayable)
			{
				SetTimeRecursive(lastPlayable, Time.deltaTime, lastSpeed);
			}
			yield return null;
		}
		m_mixRoot.SetInputWeight(index, 1f);
		m_mixRoot.SetInputWeight(lastIndex, 0f);
		_isBlending = false;
		if (hasLastPlayable)
		{
			DestoryPlayable(lastPlayable);
			m_mixRoot.DisconnectInput(lastIndex);
		}
	}

	private static void SetTimeRecursive(Playable lastPlayable, float dt, double lastSpeed)
	{
		if (!lastPlayable.IsNull() && lastPlayable.IsValid())
		{
			double time = lastPlayable.GetTime();
			lastPlayable.SetTime(time + (double)dt * lastSpeed);
			for (int i = 0; i < lastPlayable.GetInputCount(); i++)
			{
				SetTimeRecursive(lastPlayable.GetInput(i), dt, lastSpeed);
			}
		}
	}

	private void OnDestroy()
	{
		m_graph.Destroy();
	}
}

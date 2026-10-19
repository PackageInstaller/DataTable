using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

public class LoungePlayable : MonoBehaviour
{
	private PlayableGraph _graph;

	private AnimationClipPlayable _clipPlayable;

	private Animator _characterAnimator;

	private Animator _selfAnimator;

	private AnimationClip _clip;

	private bool _loop = true;

	private int _watchLayer;

	private int _idleStateHash;

	private Renderer[] _renderers;

	private bool _bound;

	private bool _watchState;

	private bool _visible;

	public void Bind(Animator characterAnimator, Animator selfAnimator, AnimationClip clip, bool loop = true, string idleStateName = "LoungeIdle", int watchLayer = 0)
	{
		Stop();
		_characterAnimator = characterAnimator;
		_selfAnimator = selfAnimator;
		_clip = clip;
		_loop = loop;
		_watchLayer = watchLayer;
		_idleStateHash = Animator.StringToHash(idleStateName);
		_bound = _characterAnimator != null && _selfAnimator != null && _clip != null;
		_watchState = true;
		if (!_bound)
		{
			Debug.LogWarning("[LoungePlayable] 绑定失败：characterAnimator/selfAnimator/clip 存在空引用");
			return;
		}
		_renderers = GetComponentsInChildren<Renderer>(includeInactive: true);
		_visible = true;
		SetVisible(visible: false);
	}

	private void LateUpdate()
	{
		if (!_bound || !_watchState)
		{
			return;
		}
		if (_characterAnimator == null || _selfAnimator == null)
		{
			Stop();
			_bound = false;
			return;
		}
		AnimatorStateInfo currentAnimatorStateInfo = _characterAnimator.GetCurrentAnimatorStateInfo(_watchLayer);
		bool flag = currentAnimatorStateInfo.shortNameHash == _idleStateHash;
		if (flag && _characterAnimator.IsInTransition(_watchLayer) && _characterAnimator.GetNextAnimatorStateInfo(_watchLayer).shortNameHash != _idleStateHash)
		{
			flag = false;
		}
		if (flag)
		{
			if (!_graph.IsValid())
			{
				BuildGraph();
			}
			if (!_visible)
			{
				SetVisible(visible: true);
			}
			float num = (_loop ? Mathf.Repeat(currentAnimatorStateInfo.normalizedTime, 1f) : Mathf.Clamp01(currentAnimatorStateInfo.normalizedTime));
			if (_clipPlayable.IsValid())
			{
				_clipPlayable.SetTime(num * _clip.length);
				_graph.Evaluate(0f);
			}
		}
		else
		{
			if (_visible)
			{
				SetVisible(visible: false);
			}
			if (_clipPlayable.IsValid())
			{
				_clipPlayable.SetTime(0.0);
			}
		}
	}

	private void SetVisible(bool visible)
	{
		if (_visible == visible)
		{
			return;
		}
		_visible = visible;
		if (_renderers == null)
		{
			return;
		}
		for (int i = 0; i < _renderers.Length; i++)
		{
			if (_renderers[i] != null)
			{
				_renderers[i].enabled = visible;
			}
		}
	}

	private void BuildGraph()
	{
		_graph = PlayableGraph.Create("GenericClip_" + _selfAnimator.name);
		_graph.SetTimeUpdateMode(DirectorUpdateMode.Manual);
		AnimationPlayableOutput output = AnimationPlayableOutput.Create(_graph, "out", _selfAnimator);
		_clipPlayable = AnimationClipPlayable.Create(_graph, _clip);
		_clipPlayable.SetApplyFootIK(value: false);
		output.SetSourcePlayable(_clipPlayable);
	}

	public void Stop()
	{
		if (_graph.IsValid())
		{
			_graph.Destroy();
		}
	}

	private void OnDisable()
	{
		Stop();
	}

	private void OnDestroy()
	{
		Stop();
	}
}

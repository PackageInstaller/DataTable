using UnityEngine;
using UnityEngine.Playables;

[RequireComponent(typeof(PlayableDirector))]
public class AnimationPlayTool : MonoBehaviour
{
	public GameObject entireMovieGo;

	public GameObject shortMovieGo;

	public string playedKey = "";

	public float jumpTime;

	public PlayableDirector playableDirector;

	public bool playAnimOnlyOnce;

	public bool playAnimWhenReturnFromBattle = true;

	public bool playAnimWhenReturnFromSubView = true;

	private void OnEnable()
	{
		if (playableDirector == null || !playedKey.IsNotNullOrEmpty())
		{
			return;
		}
		ViewAnimationManager.Register(playedKey);
		bool flag = true;
		if (playAnimOnlyOnce)
		{
			if (!ViewAnimationManager.GetIsFirstEnter(playedKey))
			{
				flag = false;
			}
		}
		else
		{
			if (!playAnimWhenReturnFromSubView && ViewAnimationManager.GetIsReturnFromSubView(playedKey))
			{
				flag = false;
			}
			if (!playAnimWhenReturnFromBattle && ViewAnimationManager.GetIsReturnFromBattle(playedKey))
			{
				flag = false;
			}
		}
		if (entireMovieGo != null)
		{
			entireMovieGo.SetActive(flag);
		}
		if (shortMovieGo != null)
		{
			shortMovieGo.SetActive(!flag);
		}
		if (flag)
		{
			playableDirector.time = 0.0;
		}
		else
		{
			playableDirector.time = jumpTime;
		}
		playableDirector.Play();
	}
}

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LeanTween : MonoBehaviour
{
	public static bool throwErrors = true;

	public static float tau = MathF.PI * 2f;

	public static float PI_DIV2 = MathF.PI / 2f;

	private static LTSeq[] sequences;

	private static LTDescr[] tweens;

	private static int[] tweensFinished;

	private static int[] tweensFinishedIds;

	private static LTDescr tween;

	private static int tweenMaxSearch = -1;

	private static int maxTweens = 400;

	private static int maxSequences = 400;

	private static int frameRendered = -1;

	private static GameObject _tweenEmpty;

	public static float dtEstimated = -1f;

	public static float dtManual;

	public static float dtActual;

	private static uint global_counter = 0u;

	private static int i;

	private static int j;

	private static int finishedCnt;

	public static AnimationCurve punch = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.112586f, 0.9976035f), new Keyframe(0.3120486f, -0.1720615f), new Keyframe(0.4316337f, 0.07030682f), new Keyframe(0.5524869f, -0.03141804f), new Keyframe(0.6549395f, 0.003909959f), new Keyframe(0.770987f, -0.009817753f), new Keyframe(0.8838775f, 0.001939224f), new Keyframe(1f, 0f));

	public static AnimationCurve shake = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.25f, 1f), new Keyframe(0.75f, -1f), new Keyframe(1f, 0f));

	private static int maxTweenReached;

	public static int startSearch = 0;

	public static LTDescr d;

	private static Action<LTEvent>[] eventListeners;

	private static GameObject[] goListeners;

	private static int eventsMaxSearch = 0;

	public static int EVENTS_MAX = 10;

	public static int LISTENERS_MAX = 10;

	private static int INIT_LISTENERS_MAX = LISTENERS_MAX;

	public static int maxSearch => tweenMaxSearch;

	public static int maxSimulataneousTweens => maxTweens;

	public static int tweensRunning
	{
		get
		{
			int num = 0;
			for (int i = 0; i <= tweenMaxSearch; i++)
			{
				if (tweens[i].toggle)
				{
					num++;
				}
			}
			return num;
		}
	}

	public static GameObject tweenEmpty
	{
		get
		{
			init(maxTweens);
			return _tweenEmpty;
		}
	}

	public static void init()
	{
		init(maxTweens);
	}

	public static void init(int maxSimultaneousTweens)
	{
		init(maxSimultaneousTweens, maxSequences);
	}

	public static void init(int maxSimultaneousTweens, int maxSimultaneousSequences)
	{
		if (tweens == null)
		{
			maxTweens = maxSimultaneousTweens;
			tweens = new LTDescr[maxTweens];
			tweensFinished = new int[maxTweens];
			tweensFinishedIds = new int[maxTweens];
			_tweenEmpty = new GameObject();
			_tweenEmpty.name = "~LeanTween";
			_tweenEmpty.AddComponent(typeof(LeanTween));
			_tweenEmpty.isStatic = true;
			_tweenEmpty.hideFlags = HideFlags.HideAndDontSave;
			UnityEngine.Object.DontDestroyOnLoad(_tweenEmpty);
			for (int i = 0; i < maxTweens; i++)
			{
				tweens[i] = new LTDescr();
			}
			SceneManager.sceneLoaded += onLevelWasLoaded54;
			sequences = new LTSeq[maxSimultaneousSequences];
			for (int j = 0; j < maxSimultaneousSequences; j++)
			{
				sequences[j] = new LTSeq();
			}
		}
	}

	public static void reset()
	{
		if (tweens != null)
		{
			for (int i = 0; i <= tweenMaxSearch; i++)
			{
				if (tweens[i] != null)
				{
					tweens[i].toggle = false;
				}
			}
		}
		tweens = null;
		UnityEngine.Object.Destroy(_tweenEmpty);
	}

	public void Update()
	{
		update();
	}

	private static void onLevelWasLoaded54(Scene scene, LoadSceneMode mode)
	{
		internalOnLevelWasLoaded(scene.buildIndex);
	}

	private static void internalOnLevelWasLoaded(int lvl)
	{
		LTGUI.reset();
	}

	public static void update()
	{
		if (frameRendered == Time.frameCount)
		{
			return;
		}
		init();
		dtEstimated = ((dtEstimated < 0f) ? 0f : (dtEstimated = Time.unscaledDeltaTime));
		dtActual = Time.deltaTime;
		maxTweenReached = 0;
		finishedCnt = 0;
		for (int i = 0; i <= tweenMaxSearch && i < maxTweens; i++)
		{
			tween = tweens[i];
			if (tween.toggle)
			{
				maxTweenReached = i;
				if (tween.updateInternal())
				{
					tweensFinished[finishedCnt] = i;
					tweensFinishedIds[finishedCnt] = tweens[i].id;
					finishedCnt++;
				}
			}
		}
		tweenMaxSearch = maxTweenReached;
		frameRendered = Time.frameCount;
		for (int j = 0; j < finishedCnt; j++)
		{
			LeanTween.j = tweensFinished[j];
			tween = tweens[LeanTween.j];
			if (tween.id == tweensFinishedIds[j])
			{
				removeTween(LeanTween.j);
				if (tween.hasExtraOnCompletes && tween.trans != null)
				{
					tween.callOnCompletes();
				}
			}
		}
	}

	public static void removeTween(int i, int uniqueId)
	{
		if (tweens[i].uniqueId == uniqueId)
		{
			removeTween(i);
		}
	}

	public static void removeTween(int i)
	{
		if (!tweens[i].toggle)
		{
			return;
		}
		tweens[i].toggle = false;
		tweens[i].counter = uint.MaxValue;
		if (tweens[i].destroyOnComplete)
		{
			if (tweens[i]._optional.ltRect != null)
			{
				LTGUI.destroy(tweens[i]._optional.ltRect.id);
			}
			else if (tweens[i].trans != null && tweens[i].trans.gameObject != _tweenEmpty)
			{
				UnityEngine.Object.Destroy(tweens[i].trans.gameObject);
			}
		}
		startSearch = i;
		if (i + 1 >= tweenMaxSearch)
		{
			startSearch = 0;
		}
	}

	public static Vector3[] add(Vector3[] a, Vector3 b)
	{
		Vector3[] array = new Vector3[a.Length];
		for (i = 0; i < a.Length; i++)
		{
			array[i] = a[i] + b;
		}
		return array;
	}

	public static float closestRot(float from, float to)
	{
		float num = 0f - (360f - to);
		float num2 = 360f + to;
		float num3 = Mathf.Abs(to - from);
		float num4 = Mathf.Abs(num - from);
		float num5 = Mathf.Abs(num2 - from);
		if (num3 < num4 && num3 < num5)
		{
			return to;
		}
		if (num4 < num5)
		{
			return num;
		}
		return num2;
	}

	public static void cancelAll()
	{
		cancelAll(callComplete: false);
	}

	public static void cancelAll(bool callComplete)
	{
		init();
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].trans != null)
			{
				if (callComplete && tweens[i].optional.onComplete != null)
				{
					tweens[i].optional.onComplete();
				}
				removeTween(i);
			}
		}
	}

	public static void cancel(GameObject gameObject)
	{
		cancel(gameObject, callOnComplete: false);
	}

	public static void cancel(GameObject gameObject, bool callOnComplete)
	{
		init();
		Transform transform = gameObject.transform;
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			LTDescr lTDescr = tweens[i];
			if (lTDescr != null && lTDescr.toggle && lTDescr.trans == transform)
			{
				if (callOnComplete && lTDescr.optional.onComplete != null)
				{
					lTDescr.optional.onComplete();
				}
				removeTween(i);
			}
		}
	}

	public static void cancel(RectTransform rect)
	{
		cancel(rect.gameObject, callOnComplete: false);
	}

	public static void cancel(GameObject gameObject, int uniqueId, bool callOnComplete = false)
	{
		if (uniqueId < 0)
		{
			return;
		}
		init();
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (tweens[num].trans == null || (tweens[num].trans.gameObject == gameObject && tweens[num].counter == num2))
		{
			if (callOnComplete && tweens[num].optional.onComplete != null)
			{
				tweens[num].optional.onComplete();
			}
			removeTween(num);
		}
	}

	public static void cancel(LTRect ltRect, int uniqueId)
	{
		if (uniqueId >= 0)
		{
			init();
			int num = uniqueId & 0xFFFF;
			int num2 = uniqueId >> 16;
			if (tweens[num]._optional.ltRect == ltRect && tweens[num].counter == num2)
			{
				removeTween(num);
			}
		}
	}

	public static void cancel(int uniqueId)
	{
		cancel(uniqueId, callOnComplete: false);
	}

	public static void cancel(int uniqueId, bool callOnComplete)
	{
		if (uniqueId < 0)
		{
			return;
		}
		init();
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (num > tweens.Length - 1)
		{
			int num3 = num - tweens.Length;
			LTSeq lTSeq = sequences[num3];
			for (int i = 0; i < maxSequences; i++)
			{
				if (lTSeq.current.tween != null)
				{
					removeTween(lTSeq.current.tween.uniqueId & 0xFFFF);
				}
				if (lTSeq.current.previous != null)
				{
					lTSeq.current = lTSeq.current.previous;
					continue;
				}
				break;
			}
		}
		else if (tweens[num].counter == num2)
		{
			if (callOnComplete && tweens[num].optional.onComplete != null)
			{
				tweens[num].optional.onComplete();
			}
			removeTween(num);
		}
	}

	public static LTDescr descr(int uniqueId)
	{
		init();
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (tweens[num] != null && tweens[num].uniqueId == uniqueId && tweens[num].counter == num2)
		{
			return tweens[num];
		}
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].uniqueId == uniqueId && tweens[i].counter == num2)
			{
				return tweens[i];
			}
		}
		return null;
	}

	public static LTDescr description(int uniqueId)
	{
		return descr(uniqueId);
	}

	public static LTDescr[] descriptions(GameObject gameObject = null)
	{
		if (gameObject == null)
		{
			return null;
		}
		List<LTDescr> list = new List<LTDescr>();
		Transform transform = gameObject.transform;
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].toggle && tweens[i].trans == transform)
			{
				list.Add(tweens[i]);
			}
		}
		return list.ToArray();
	}

	[Obsolete("Use 'pause( id )' instead")]
	public static void pause(GameObject gameObject, int uniqueId)
	{
		pause(uniqueId);
	}

	public static void pause(int uniqueId)
	{
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (tweens[num].counter == num2)
		{
			tweens[num].pause();
		}
	}

	public static void pause(GameObject gameObject)
	{
		Transform transform = gameObject.transform;
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].trans == transform)
			{
				tweens[i].pause();
			}
		}
	}

	public static void pauseAll()
	{
		init();
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			tweens[i].pause();
		}
	}

	public static void resumeAll()
	{
		init();
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			tweens[i].resume();
		}
	}

	[Obsolete("Use 'resume( id )' instead")]
	public static void resume(GameObject gameObject, int uniqueId)
	{
		resume(uniqueId);
	}

	public static void resume(int uniqueId)
	{
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (tweens[num].counter == num2)
		{
			tweens[num].resume();
		}
	}

	public static void resume(GameObject gameObject)
	{
		Transform transform = gameObject.transform;
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].trans == transform)
			{
				tweens[i].resume();
			}
		}
	}

	public static bool isPaused(GameObject gameObject = null)
	{
		if (gameObject == null)
		{
			for (int i = 0; i <= tweenMaxSearch; i++)
			{
				if (object.Equals(tweens[i].direction, 0f))
				{
					return true;
				}
			}
			return false;
		}
		Transform transform = gameObject.transform;
		for (int j = 0; j <= tweenMaxSearch; j++)
		{
			if (object.Equals(tweens[j].direction, 0f) && tweens[j].trans == transform)
			{
				return true;
			}
		}
		return false;
	}

	public static bool isPaused(RectTransform rect)
	{
		return isTweening(rect.gameObject);
	}

	public static bool isPaused(int uniqueId)
	{
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (num < 0 || num >= maxTweens)
		{
			return false;
		}
		if (tweens[num].counter == num2 && object.Equals(tweens[i].direction, 0f))
		{
			return true;
		}
		return false;
	}

	public static bool isTweening(GameObject gameObject = null)
	{
		if (gameObject == null)
		{
			for (int i = 0; i <= tweenMaxSearch; i++)
			{
				if (tweens[i].toggle)
				{
					return true;
				}
			}
			return false;
		}
		Transform transform = gameObject.transform;
		for (int j = 0; j <= tweenMaxSearch; j++)
		{
			if (tweens[j].toggle && tweens[j].trans == transform)
			{
				return true;
			}
		}
		return false;
	}

	public static bool isTweening(RectTransform rect)
	{
		return isTweening(rect.gameObject);
	}

	public static bool isTweening(int uniqueId)
	{
		int num = uniqueId & 0xFFFF;
		int num2 = uniqueId >> 16;
		if (num < 0 || num >= maxTweens)
		{
			return false;
		}
		if (tweens[num].counter == num2 && tweens[num].toggle)
		{
			return true;
		}
		return false;
	}

	public static bool isTweening(LTRect ltRect)
	{
		for (int i = 0; i <= tweenMaxSearch; i++)
		{
			if (tweens[i].toggle && tweens[i]._optional.ltRect == ltRect)
			{
				return true;
			}
		}
		return false;
	}

	public static void drawBezierPath(Vector3 a, Vector3 b, Vector3 c, Vector3 d, float arrowSize = 0f, Transform arrowTransform = null)
	{
		Vector3 vector = a;
		Vector3 vector2 = -a + 3f * (b - c) + d;
		Vector3 vector3 = 3f * (a + c) - 6f * b;
		Vector3 vector4 = 3f * (b - a);
		if (arrowSize > 0f)
		{
			Vector3 position = arrowTransform.position;
			Quaternion rotation = arrowTransform.rotation;
			float num = 0f;
			for (float num2 = 1f; num2 <= 120f; num2++)
			{
				float num3 = num2 / 120f;
				Vector3 vector5 = ((vector2 * num3 + vector3) * num3 + vector4) * num3 + a;
				Gizmos.DrawLine(vector, vector5);
				num += (vector5 - vector).magnitude;
				if (num > 1f)
				{
					num--;
					arrowTransform.position = vector5;
					arrowTransform.LookAt(vector, Vector3.forward);
					Vector3 vector6 = arrowTransform.TransformDirection(Vector3.right);
					Vector3 normalized = (vector - vector5).normalized;
					Gizmos.DrawLine(vector5, vector5 + (vector6 + normalized) * arrowSize);
					vector6 = arrowTransform.TransformDirection(-Vector3.right);
					Gizmos.DrawLine(vector5, vector5 + (vector6 + normalized) * arrowSize);
				}
				vector = vector5;
			}
			arrowTransform.position = position;
			arrowTransform.rotation = rotation;
		}
		else
		{
			for (float num4 = 1f; num4 <= 30f; num4++)
			{
				float num3 = num4 / 30f;
				Vector3 vector5 = ((vector2 * num3 + vector3) * num3 + vector4) * num3 + a;
				Gizmos.DrawLine(vector, vector5);
				vector = vector5;
			}
		}
	}

	public static object logError(string error)
	{
		if (throwErrors)
		{
			Debug.LogError(error);
		}
		else
		{
			Debug.Log(error);
		}
		return null;
	}

	public static LTDescr options(LTDescr seed)
	{
		Debug.LogError("error this function is no longer used");
		return null;
	}

	public static LTDescr options()
	{
		init();
		bool flag = false;
		j = 0;
		i = startSearch;
		while (j <= maxTweens)
		{
			if (j >= maxTweens)
			{
				return logError("LeanTween - You have run out of available spaces for tweening. To avoid this error increase the number of spaces to available for tweening when you initialize the LeanTween class ex: LeanTween.init( " + maxTweens * 2 + " );") as LTDescr;
			}
			if (i >= maxTweens)
			{
				i = 0;
			}
			if (!tweens[i].toggle)
			{
				if (i + 1 > tweenMaxSearch && i + 1 < maxTweens)
				{
					tweenMaxSearch = i + 1;
				}
				startSearch = i + 1;
				flag = true;
				break;
			}
			j++;
			i++;
		}
		if (!flag)
		{
			logError("no available tween found!");
		}
		tweens[i].reset();
		global_counter++;
		if (global_counter > 32768)
		{
			global_counter = 0u;
		}
		tweens[i].setId((uint)i, global_counter);
		return tweens[i];
	}

	private static LTDescr pushNewTween(GameObject gameObject, Vector3 to, float time, LTDescr tween)
	{
		init(maxTweens);
		if (gameObject == null || tween == null)
		{
			return null;
		}
		tween.trans = gameObject.transform;
		tween.to = to;
		tween.time = time;
		if (tween.time <= 0f)
		{
			tween.updateInternal();
		}
		return tween;
	}

	public static LTDescr play(RectTransform rectTransform, Sprite[] sprites)
	{
		float time = 0.25f * (float)sprites.Length;
		return pushNewTween(rectTransform.gameObject, new Vector3((float)sprites.Length - 1f, 0f, 0f), time, options().setCanvasPlaySprite().setSprites(sprites).setRepeat(-1));
	}

	public static LTSeq sequence(bool initSequence = true)
	{
		init(maxTweens);
		for (int i = 0; i < sequences.Length; i++)
		{
			if ((sequences[i].tween != null && sequences[i].tween.toggle) || sequences[i].toggle)
			{
				continue;
			}
			LTSeq lTSeq = sequences[i];
			if (initSequence)
			{
				lTSeq.init((uint)(i + tweens.Length), global_counter);
				global_counter++;
				if (global_counter > 32768)
				{
					global_counter = 0u;
				}
			}
			else
			{
				lTSeq.reset();
			}
			return lTSeq;
		}
		return null;
	}

	public static LTDescr alpha(GameObject gameObject, float to, float time)
	{
		LTDescr lTDescr = pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setAlpha());
		SpriteRenderer component = gameObject.GetComponent<SpriteRenderer>();
		lTDescr.spriteRen = component;
		return lTDescr;
	}

	public static LTDescr alpha(LTRect ltRect, float to, float time)
	{
		ltRect.alphaEnabled = true;
		return pushNewTween(tweenEmpty, new Vector3(to, 0f, 0f), time, options().setGUIAlpha().setRect(ltRect));
	}

	public static LTDescr textAlpha(RectTransform rectTransform, float to, float time)
	{
		return pushNewTween(rectTransform.gameObject, new Vector3(to, 0f, 0f), time, options().setTextAlpha());
	}

	public static LTDescr alphaText(RectTransform rectTransform, float to, float time)
	{
		return pushNewTween(rectTransform.gameObject, new Vector3(to, 0f, 0f), time, options().setTextAlpha());
	}

	public static LTDescr alphaCanvas(CanvasGroup canvasGroup, float to, float time)
	{
		return pushNewTween(canvasGroup.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasGroupAlpha());
	}

	public static LTDescr alphaVertex(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setAlphaVertex());
	}

	public static LTDescr color(GameObject gameObject, Color to, float time)
	{
		LTDescr lTDescr = pushNewTween(gameObject, new Vector3(1f, to.a, 0f), time, options().setColor().setPoint(new Vector3(to.r, to.g, to.b)));
		SpriteRenderer component = gameObject.GetComponent<SpriteRenderer>();
		lTDescr.spriteRen = component;
		return lTDescr;
	}

	public static LTDescr textColor(RectTransform rectTransform, Color to, float time)
	{
		return pushNewTween(rectTransform.gameObject, new Vector3(1f, to.a, 0f), time, options().setTextColor().setPoint(new Vector3(to.r, to.g, to.b)));
	}

	public static LTDescr colorText(RectTransform rectTransform, Color to, float time)
	{
		return pushNewTween(rectTransform.gameObject, new Vector3(1f, to.a, 0f), time, options().setTextColor().setPoint(new Vector3(to.r, to.g, to.b)));
	}

	public static LTDescr delayedCall(float delayTime, Action callback)
	{
		return pushNewTween(tweenEmpty, Vector3.zero, delayTime, options().setCallback().setOnComplete(callback));
	}

	public static LTDescr delayedCall(float delayTime, Action<object> callback)
	{
		return pushNewTween(tweenEmpty, Vector3.zero, delayTime, options().setCallback().setOnComplete(callback));
	}

	public static LTDescr delayedCall(GameObject gameObject, float delayTime, Action callback)
	{
		return pushNewTween(gameObject, Vector3.zero, delayTime, options().setCallback().setOnComplete(callback));
	}

	public static LTDescr delayedCall(GameObject gameObject, float delayTime, Action<object> callback)
	{
		return pushNewTween(gameObject, Vector3.zero, delayTime, options().setCallback().setOnComplete(callback));
	}

	public static LTDescr destroyAfter(LTRect rect, float delayTime)
	{
		return pushNewTween(tweenEmpty, Vector3.zero, delayTime, options().setCallback().setRect(rect).setDestroyOnComplete(doesDestroy: true));
	}

	public static LTDescr move(GameObject gameObject, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setMove());
	}

	public static LTDescr move(GameObject gameObject, Vector2 to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to.x, to.y, gameObject.transform.position.z), time, options().setMove());
	}

	public static LTDescr move(GameObject gameObject, Vector3[] to, float time)
	{
		d = options().setMoveCurved();
		if (d.optional.path == null)
		{
			d.optional.path = new LTBezierPath(to);
		}
		else
		{
			d.optional.path.setPoints(to);
		}
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr move(GameObject gameObject, LTBezierPath to, float time)
	{
		d = options().setMoveCurved();
		d.optional.path = to;
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr move(GameObject gameObject, LTSpline to, float time)
	{
		d = options().setMoveSpline();
		d.optional.spline = to;
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr moveSpline(GameObject gameObject, Vector3[] to, float time)
	{
		d = options().setMoveSpline();
		d.optional.spline = new LTSpline(to);
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr moveSpline(GameObject gameObject, LTSpline to, float time)
	{
		d = options().setMoveSpline();
		d.optional.spline = to;
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr moveSplineLocal(GameObject gameObject, Vector3[] to, float time)
	{
		d = options().setMoveSplineLocal();
		d.optional.spline = new LTSpline(to);
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr move(LTRect ltRect, Vector2 to, float time)
	{
		return pushNewTween(tweenEmpty, to, time, options().setGUIMove().setRect(ltRect));
	}

	public static LTDescr moveMargin(LTRect ltRect, Vector2 to, float time)
	{
		return pushNewTween(tweenEmpty, to, time, options().setGUIMoveMargin().setRect(ltRect));
	}

	public static LTDescr moveX(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveX());
	}

	public static LTDescr moveY(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveY());
	}

	public static LTDescr moveZ(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveZ());
	}

	public static LTDescr moveLocal(GameObject gameObject, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setMoveLocal());
	}

	public static LTDescr moveLocal(GameObject gameObject, Vector3[] to, float time)
	{
		d = options().setMoveCurvedLocal();
		if (d.optional.path == null)
		{
			d.optional.path = new LTBezierPath(to);
		}
		else
		{
			d.optional.path.setPoints(to);
		}
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr moveLocalX(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveLocalX());
	}

	public static LTDescr moveLocalY(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveLocalY());
	}

	public static LTDescr moveLocalZ(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setMoveLocalZ());
	}

	public static LTDescr moveLocal(GameObject gameObject, LTBezierPath to, float time)
	{
		d = options().setMoveCurvedLocal();
		d.optional.path = to;
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr moveLocal(GameObject gameObject, LTSpline to, float time)
	{
		d = options().setMoveSplineLocal();
		d.optional.spline = to;
		return pushNewTween(gameObject, new Vector3(1f, 0f, 0f), time, d);
	}

	public static LTDescr move(GameObject gameObject, Transform to, float time)
	{
		return pushNewTween(gameObject, Vector3.zero, time, options().setTo(to).setMoveToTransform());
	}

	public static LTDescr rotate(GameObject gameObject, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setRotate());
	}

	public static LTDescr rotate(LTRect ltRect, float to, float time)
	{
		return pushNewTween(tweenEmpty, new Vector3(to, 0f, 0f), time, options().setGUIRotate().setRect(ltRect));
	}

	public static LTDescr rotateLocal(GameObject gameObject, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setRotateLocal());
	}

	public static LTDescr rotateX(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setRotateX());
	}

	public static LTDescr rotateY(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setRotateY());
	}

	public static LTDescr rotateZ(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setRotateZ());
	}

	public static LTDescr rotateAround(GameObject gameObject, Vector3 axis, float add, float time)
	{
		return pushNewTween(gameObject, new Vector3(add, 0f, 0f), time, options().setAxis(axis).setRotateAround());
	}

	public static LTDescr rotateAroundLocal(GameObject gameObject, Vector3 axis, float add, float time)
	{
		return pushNewTween(gameObject, new Vector3(add, 0f, 0f), time, options().setRotateAroundLocal().setAxis(axis));
	}

	public static LTDescr scale(GameObject gameObject, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setScale());
	}

	public static LTDescr scale(LTRect ltRect, Vector2 to, float time)
	{
		return pushNewTween(tweenEmpty, to, time, options().setGUIScale().setRect(ltRect));
	}

	public static LTDescr scaleX(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setScaleX());
	}

	public static LTDescr scaleY(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setScaleY());
	}

	public static LTDescr scaleZ(GameObject gameObject, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setScaleZ());
	}

	public static LTDescr value(GameObject gameObject, float from, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setCallback().setFrom(new Vector3(from, 0f, 0f)));
	}

	public static LTDescr value(float from, float to, float time)
	{
		return pushNewTween(tweenEmpty, new Vector3(to, 0f, 0f), time, options().setCallback().setFrom(new Vector3(from, 0f, 0f)));
	}

	public static LTDescr value(GameObject gameObject, Vector2 from, Vector2 to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to.x, to.y, 0f), time, options().setValue3().setTo(new Vector3(to.x, to.y, 0f)).setFrom(new Vector3(from.x, from.y, 0f)));
	}

	public static LTDescr value(GameObject gameObject, Vector3 from, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setValue3().setFrom(from));
	}

	public static LTDescr value(GameObject gameObject, Color from, Color to, float time)
	{
		LTDescr lTDescr = pushNewTween(gameObject, new Vector3(1f, to.a, 0f), time, options().setCallbackColor().setPoint(new Vector3(to.r, to.g, to.b)).setFromColor(from)
			.setHasInitialized(has: false));
		SpriteRenderer component = gameObject.GetComponent<SpriteRenderer>();
		lTDescr.spriteRen = component;
		return lTDescr;
	}

	public static LTDescr value(GameObject gameObject, Action<float> callOnUpdate, float from, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setCallback().setTo(new Vector3(to, 0f, 0f)).setFrom(new Vector3(from, 0f, 0f))
			.setOnUpdate(callOnUpdate));
	}

	public static LTDescr value(GameObject gameObject, Action<float, float> callOnUpdateRatio, float from, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setCallback().setTo(new Vector3(to, 0f, 0f)).setFrom(new Vector3(from, 0f, 0f))
			.setOnUpdateRatio(callOnUpdateRatio));
	}

	public static LTDescr value(GameObject gameObject, Action<Color> callOnUpdate, Color from, Color to, float time)
	{
		return pushNewTween(gameObject, new Vector3(1f, to.a, 0f), time, options().setCallbackColor().setPoint(new Vector3(to.r, to.g, to.b)).setAxis(new Vector3(from.r, from.g, from.b))
			.setFrom(new Vector3(0f, from.a, 0f))
			.setHasInitialized(has: false)
			.setOnUpdateColor(callOnUpdate));
	}

	public static LTDescr value(GameObject gameObject, Action<Color, object> callOnUpdate, Color from, Color to, float time)
	{
		return pushNewTween(gameObject, new Vector3(1f, to.a, 0f), time, options().setCallbackColor().setPoint(new Vector3(to.r, to.g, to.b)).setAxis(new Vector3(from.r, from.g, from.b))
			.setFrom(new Vector3(0f, from.a, 0f))
			.setHasInitialized(has: false)
			.setOnUpdateColor(callOnUpdate));
	}

	public static LTDescr value(GameObject gameObject, Action<Vector2> callOnUpdate, Vector2 from, Vector2 to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to.x, to.y, 0f), time, options().setValue3().setTo(new Vector3(to.x, to.y, 0f)).setFrom(new Vector3(from.x, from.y, 0f))
			.setOnUpdateVector2(callOnUpdate));
	}

	public static LTDescr value(GameObject gameObject, Action<Vector3> callOnUpdate, Vector3 from, Vector3 to, float time)
	{
		return pushNewTween(gameObject, to, time, options().setValue3().setTo(to).setFrom(from)
			.setOnUpdateVector3(callOnUpdate));
	}

	public static LTDescr value(GameObject gameObject, Action<float, object> callOnUpdate, float from, float to, float time)
	{
		return pushNewTween(gameObject, new Vector3(to, 0f, 0f), time, options().setCallback().setTo(new Vector3(to, 0f, 0f)).setFrom(new Vector3(from, 0f, 0f))
			.setOnUpdate(callOnUpdate, gameObject));
	}

	public static LTDescr delayedSound(AudioClip audio, Vector3 pos, float volume)
	{
		return pushNewTween(tweenEmpty, pos, 0f, options().setDelayedSound().setTo(pos).setFrom(new Vector3(volume, 0f, 0f))
			.setAudio(audio));
	}

	public static LTDescr delayedSound(GameObject gameObject, AudioClip audio, Vector3 pos, float volume)
	{
		return pushNewTween(gameObject, pos, 0f, options().setDelayedSound().setTo(pos).setFrom(new Vector3(volume, 0f, 0f))
			.setAudio(audio));
	}

	public static LTDescr move(RectTransform rectTrans, Vector3 to, float time)
	{
		return pushNewTween(rectTrans.gameObject, to, time, options().setCanvasMove().setRect(rectTrans));
	}

	public static LTDescr moveX(RectTransform rectTrans, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasMoveX().setRect(rectTrans));
	}

	public static LTDescr moveY(RectTransform rectTrans, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasMoveY().setRect(rectTrans));
	}

	public static LTDescr moveZ(RectTransform rectTrans, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasMoveZ().setRect(rectTrans));
	}

	public static LTDescr rotate(RectTransform rectTrans, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasRotateAround().setRect(rectTrans).setAxis(Vector3.forward));
	}

	public static LTDescr rotate(RectTransform rectTrans, Vector3 to, float time)
	{
		return pushNewTween(rectTrans.gameObject, to, time, options().setCanvasRotateAround().setRect(rectTrans).setAxis(Vector3.forward));
	}

	public static LTDescr rotateAround(RectTransform rectTrans, Vector3 axis, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasRotateAround().setRect(rectTrans).setAxis(axis));
	}

	public static LTDescr rotateAroundLocal(RectTransform rectTrans, Vector3 axis, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasRotateAroundLocal().setRect(rectTrans).setAxis(axis));
	}

	public static LTDescr scale(RectTransform rectTrans, Vector3 to, float time)
	{
		return pushNewTween(rectTrans.gameObject, to, time, options().setCanvasScale().setRect(rectTrans));
	}

	public static LTDescr size(RectTransform rectTrans, Vector2 to, float time)
	{
		return pushNewTween(rectTrans.gameObject, to, time, options().setCanvasSizeDelta().setRect(rectTrans));
	}

	public static LTDescr alpha(RectTransform rectTrans, float to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(to, 0f, 0f), time, options().setCanvasAlpha().setRect(rectTrans));
	}

	public static LTDescr color(RectTransform rectTrans, Color to, float time)
	{
		return pushNewTween(rectTrans.gameObject, new Vector3(1f, to.a, 0f), time, options().setCanvasColor().setRect(rectTrans).setPoint(new Vector3(to.r, to.g, to.b)));
	}

	public static float tweenOnCurve(LTDescr tweenDescr, float ratioPassed)
	{
		return tweenDescr.from.x + tweenDescr.diff.x * tweenDescr.optional.animationCurve.Evaluate(ratioPassed);
	}

	public static Vector3 tweenOnCurveVector(LTDescr tweenDescr, float ratioPassed)
	{
		return new Vector3(tweenDescr.from.x + tweenDescr.diff.x * tweenDescr.optional.animationCurve.Evaluate(ratioPassed), tweenDescr.from.y + tweenDescr.diff.y * tweenDescr.optional.animationCurve.Evaluate(ratioPassed), tweenDescr.from.z + tweenDescr.diff.z * tweenDescr.optional.animationCurve.Evaluate(ratioPassed));
	}

	public static float easeOutQuadOpt(float start, float diff, float ratioPassed)
	{
		return (0f - diff) * ratioPassed * (ratioPassed - 2f) + start;
	}

	public static float easeInQuadOpt(float start, float diff, float ratioPassed)
	{
		return diff * ratioPassed * ratioPassed + start;
	}

	public static float easeInOutQuadOpt(float start, float diff, float ratioPassed)
	{
		ratioPassed /= 0.5f;
		if (ratioPassed < 1f)
		{
			return diff / 2f * ratioPassed * ratioPassed + start;
		}
		ratioPassed--;
		return (0f - diff) / 2f * (ratioPassed * (ratioPassed - 2f) - 1f) + start;
	}

	public static Vector3 easeInOutQuadOpt(Vector3 start, Vector3 diff, float ratioPassed)
	{
		ratioPassed /= 0.5f;
		if (ratioPassed < 1f)
		{
			return diff / 2f * ratioPassed * ratioPassed + start;
		}
		ratioPassed--;
		return -diff / 2f * (ratioPassed * (ratioPassed - 2f) - 1f) + start;
	}

	public static float linear(float start, float end, float val)
	{
		return Mathf.Lerp(start, end, val);
	}

	public static float clerp(float start, float end, float val)
	{
		float num = 0f;
		float num2 = 360f;
		float num3 = Mathf.Abs((num2 - num) / 2f);
		float num4 = 0f;
		float num5 = 0f;
		if (end - start < 0f - num3)
		{
			num5 = (num2 - start + end) * val;
			return start + num5;
		}
		if (end - start > num3)
		{
			num5 = (0f - (num2 - end + start)) * val;
			return start + num5;
		}
		return start + (end - start) * val;
	}

	public static float spring(float start, float end, float val)
	{
		val = Mathf.Clamp01(val);
		val = (Mathf.Sin(val * MathF.PI * (0.2f + 2.5f * val * val * val)) * Mathf.Pow(1f - val, 2.2f) + val) * (1f + 1.2f * (1f - val));
		return start + (end - start) * val;
	}

	public static float easeInQuad(float start, float end, float val)
	{
		end -= start;
		return end * val * val + start;
	}

	public static float easeOutQuad(float start, float end, float val)
	{
		end -= start;
		return (0f - end) * val * (val - 2f) + start;
	}

	public static float easeInOutQuad(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return end / 2f * val * val + start;
		}
		val--;
		return (0f - end) / 2f * (val * (val - 2f) - 1f) + start;
	}

	public static float easeInOutQuadOpt2(float start, float diffBy2, float val, float val2)
	{
		val /= 0.5f;
		if (val < 1f)
		{
			return diffBy2 * val2 + start;
		}
		val--;
		return (0f - diffBy2) * (val2 - 2f - 1f) + start;
	}

	public static float easeInCubic(float start, float end, float val)
	{
		end -= start;
		return end * val * val * val + start;
	}

	public static float easeOutCubic(float start, float end, float val)
	{
		val--;
		end -= start;
		return end * (val * val * val + 1f) + start;
	}

	public static float easeInOutCubic(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return end / 2f * val * val * val + start;
		}
		val -= 2f;
		return end / 2f * (val * val * val + 2f) + start;
	}

	public static float easeInQuart(float start, float end, float val)
	{
		end -= start;
		return end * val * val * val * val + start;
	}

	public static float easeOutQuart(float start, float end, float val)
	{
		val--;
		end -= start;
		return (0f - end) * (val * val * val * val - 1f) + start;
	}

	public static float easeInOutQuart(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return end / 2f * val * val * val * val + start;
		}
		val -= 2f;
		return (0f - end) / 2f * (val * val * val * val - 2f) + start;
	}

	public static float easeInQuint(float start, float end, float val)
	{
		end -= start;
		return end * val * val * val * val * val + start;
	}

	public static float easeOutQuint(float start, float end, float val)
	{
		val--;
		end -= start;
		return end * (val * val * val * val * val + 1f) + start;
	}

	public static float easeInOutQuint(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return end / 2f * val * val * val * val * val + start;
		}
		val -= 2f;
		return end / 2f * (val * val * val * val * val + 2f) + start;
	}

	public static float easeInSine(float start, float end, float val)
	{
		end -= start;
		return (0f - end) * Mathf.Cos(val / 1f * (MathF.PI / 2f)) + end + start;
	}

	public static float easeOutSine(float start, float end, float val)
	{
		end -= start;
		return end * Mathf.Sin(val / 1f * (MathF.PI / 2f)) + start;
	}

	public static float easeInOutSine(float start, float end, float val)
	{
		end -= start;
		return (0f - end) / 2f * (Mathf.Cos(MathF.PI * val / 1f) - 1f) + start;
	}

	public static float easeInExpo(float start, float end, float val)
	{
		end -= start;
		return end * Mathf.Pow(2f, 10f * (val / 1f - 1f)) + start;
	}

	public static float easeOutExpo(float start, float end, float val)
	{
		end -= start;
		return end * (0f - Mathf.Pow(2f, -10f * val / 1f) + 1f) + start;
	}

	public static float easeInOutExpo(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return end / 2f * Mathf.Pow(2f, 10f * (val - 1f)) + start;
		}
		val--;
		return end / 2f * (0f - Mathf.Pow(2f, -10f * val) + 2f) + start;
	}

	public static float easeInCirc(float start, float end, float val)
	{
		end -= start;
		return (0f - end) * (Mathf.Sqrt(1f - val * val) - 1f) + start;
	}

	public static float easeOutCirc(float start, float end, float val)
	{
		val--;
		end -= start;
		return end * Mathf.Sqrt(1f - val * val) + start;
	}

	public static float easeInOutCirc(float start, float end, float val)
	{
		val /= 0.5f;
		end -= start;
		if (val < 1f)
		{
			return (0f - end) / 2f * (Mathf.Sqrt(1f - val * val) - 1f) + start;
		}
		val -= 2f;
		return end / 2f * (Mathf.Sqrt(1f - val * val) + 1f) + start;
	}

	public static float easeInBounce(float start, float end, float val)
	{
		end -= start;
		float num = 1f;
		return end - easeOutBounce(0f, end, num - val) + start;
	}

	public static float easeOutBounce(float start, float end, float val)
	{
		val /= 1f;
		end -= start;
		if (val < 0.36363637f)
		{
			return end * (7.5625f * val * val) + start;
		}
		if (val < 0.72727275f)
		{
			val -= 0.54545456f;
			return end * (7.5625f * val * val + 0.75f) + start;
		}
		if ((double)val < 0.9090909090909091)
		{
			val -= 0.8181818f;
			return end * (7.5625f * val * val + 0.9375f) + start;
		}
		val -= 21f / 22f;
		return end * (7.5625f * val * val + 63f / 64f) + start;
	}

	public static float easeInOutBounce(float start, float end, float val)
	{
		end -= start;
		float num = 1f;
		if (val < num / 2f)
		{
			return easeInBounce(0f, end, val * 2f) * 0.5f + start;
		}
		return easeOutBounce(0f, end, val * 2f - num) * 0.5f + end * 0.5f + start;
	}

	public static float easeInBack(float start, float end, float val, float overshoot = 1f)
	{
		end -= start;
		val /= 1f;
		float num = 1.70158f * overshoot;
		return end * val * val * ((num + 1f) * val - num) + start;
	}

	public static float easeOutBack(float start, float end, float val, float overshoot = 1f)
	{
		float num = 1.70158f * overshoot;
		end -= start;
		val = val / 1f - 1f;
		return end * (val * val * ((num + 1f) * val + num) + 1f) + start;
	}

	public static float easeInOutBack(float start, float end, float val, float overshoot = 1f)
	{
		float num = 1.70158f * overshoot;
		end -= start;
		val /= 0.5f;
		if (val < 1f)
		{
			num *= 1.525f * overshoot;
			return end / 2f * (val * val * ((num + 1f) * val - num)) + start;
		}
		val -= 2f;
		num *= 1.525f * overshoot;
		return end / 2f * (val * val * ((num + 1f) * val + num) + 2f) + start;
	}

	public static float easeInElastic(float start, float end, float val, float overshoot = 1f, float period = 0.3f)
	{
		end -= start;
		float num = 0f;
		float num2 = 0f;
		if (val == 0f)
		{
			return start;
		}
		if (val == 1f)
		{
			return start + end;
		}
		if (num2 == 0f || num2 < Mathf.Abs(end))
		{
			num2 = end;
			num = period / 4f;
		}
		else
		{
			num = period / (MathF.PI * 2f) * Mathf.Asin(end / num2);
		}
		if (overshoot > 1f && val > 0.6f)
		{
			overshoot = 1f + (1f - val) / 0.4f * (overshoot - 1f);
		}
		val--;
		return start - num2 * Mathf.Pow(2f, 10f * val) * Mathf.Sin((val - num) * (MathF.PI * 2f) / period) * overshoot;
	}

	public static float easeOutElastic(float start, float end, float val, float overshoot = 1f, float period = 0.3f)
	{
		end -= start;
		float num = 0f;
		float num2 = 0f;
		if (val == 0f)
		{
			return start;
		}
		if (val == 1f)
		{
			return start + end;
		}
		if (num2 == 0f || num2 < Mathf.Abs(end))
		{
			num2 = end;
			num = period / 4f;
		}
		else
		{
			num = period / (MathF.PI * 2f) * Mathf.Asin(end / num2);
		}
		if (overshoot > 1f && val < 0.4f)
		{
			overshoot = 1f + val / 0.4f * (overshoot - 1f);
		}
		return start + end + num2 * Mathf.Pow(2f, -10f * val) * Mathf.Sin((val - num) * (MathF.PI * 2f) / period) * overshoot;
	}

	public static float easeInOutElastic(float start, float end, float val, float overshoot = 1f, float period = 0.3f)
	{
		end -= start;
		float num = 0f;
		float num2 = 0f;
		if (val == 0f)
		{
			return start;
		}
		val /= 0.5f;
		if (val == 2f)
		{
			return start + end;
		}
		if (num2 == 0f || num2 < Mathf.Abs(end))
		{
			num2 = end;
			num = period / 4f;
		}
		else
		{
			num = period / (MathF.PI * 2f) * Mathf.Asin(end / num2);
		}
		if (overshoot > 1f)
		{
			if (val < 0.2f)
			{
				overshoot = 1f + val / 0.2f * (overshoot - 1f);
			}
			else if (val > 0.8f)
			{
				overshoot = 1f + (1f - val) / 0.2f * (overshoot - 1f);
			}
		}
		if (val < 1f)
		{
			val--;
			return start - 0.5f * (num2 * Mathf.Pow(2f, 10f * val) * Mathf.Sin((val - num) * (MathF.PI * 2f) / period)) * overshoot;
		}
		val--;
		return end + start + num2 * Mathf.Pow(2f, -10f * val) * Mathf.Sin((val - num) * (MathF.PI * 2f) / period) * 0.5f * overshoot;
	}

	public static LTDescr followDamp(Transform trans, Transform target, LeanProp prop, float smoothTime, float maxSpeed = -1f)
	{
		LTDescr d = pushNewTween(trans.gameObject, Vector3.zero, float.MaxValue, options().setFollow().setTarget(target));
		switch (prop)
		{
		case LeanProp.localPosition:
			d.optional.axis = d.trans.localPosition;
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.damp(d.optional.axis, d.toTrans.localPosition, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime);
				d.trans.localPosition = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.position:
			d.diff = d.trans.position;
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.damp(d.optional.axis, d.toTrans.position, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime);
				d.trans.position = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.localX:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosX(LeanSmooth.damp(d.trans.localPosition.x, d.toTrans.localPosition.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.localY:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosY(LeanSmooth.damp(d.trans.localPosition.y, d.toTrans.localPosition.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.localZ:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosZ(LeanSmooth.damp(d.trans.localPosition.z, d.toTrans.localPosition.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.x:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosX(LeanSmooth.damp(d.trans.position.x, d.toTrans.position.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.y:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosY(LeanSmooth.damp(d.trans.position.y, d.toTrans.position.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.z:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosZ(LeanSmooth.damp(d.trans.position.z, d.toTrans.position.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime));
			};
			break;
		case LeanProp.scale:
			d.easeInternal = delegate
			{
				d.trans.localScale = LeanSmooth.damp(d.trans.localScale, d.toTrans.localScale, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime);
			};
			break;
		case LeanProp.color:
			d.easeInternal = delegate
			{
				Color color = LeanSmooth.damp(d.trans.LeanColor(), d.toTrans.LeanColor(), ref d.optional.color, smoothTime, maxSpeed, Time.deltaTime);
				d.trans.GetComponent<Renderer>().material.color = color;
			};
			break;
		}
		return d;
	}

	public static LTDescr followSpring(Transform trans, Transform target, LeanProp prop, float smoothTime, float maxSpeed = -1f, float friction = 2f, float accelRate = 0.5f)
	{
		LTDescr d = pushNewTween(trans.gameObject, Vector3.zero, float.MaxValue, options().setFollow().setTarget(target));
		switch (prop)
		{
		case LeanProp.localPosition:
			d.optional.axis = d.trans.localPosition;
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.spring(d.optional.axis, d.toTrans.localPosition, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate);
				d.trans.localPosition = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.position:
			d.diff = d.trans.position;
			d.easeInternal = delegate
			{
				d.diff = LeanSmooth.spring(d.diff, d.toTrans.position, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate);
				d.trans.position = d.diff;
			};
			break;
		case LeanProp.localX:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosX(LeanSmooth.spring(d.trans.localPosition.x, d.toTrans.localPosition.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.localY:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosY(LeanSmooth.spring(d.trans.localPosition.y, d.toTrans.localPosition.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.localZ:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosZ(LeanSmooth.spring(d.trans.localPosition.z, d.toTrans.localPosition.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.x:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosX(LeanSmooth.spring(d.trans.position.x, d.toTrans.position.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.y:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosY(LeanSmooth.spring(d.trans.position.y, d.toTrans.position.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.z:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosZ(LeanSmooth.spring(d.trans.position.z, d.toTrans.position.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate));
			};
			break;
		case LeanProp.scale:
			d.easeInternal = delegate
			{
				d.trans.localScale = LeanSmooth.spring(d.trans.localScale, d.toTrans.localScale, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate);
			};
			break;
		case LeanProp.color:
			d.easeInternal = delegate
			{
				Color color = LeanSmooth.spring(d.trans.LeanColor(), d.toTrans.LeanColor(), ref d.optional.color, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate);
				d.trans.GetComponent<Renderer>().material.color = color;
			};
			break;
		}
		return d;
	}

	public static LTDescr followBounceOut(Transform trans, Transform target, LeanProp prop, float smoothTime, float maxSpeed = -1f, float friction = 2f, float accelRate = 0.5f, float hitDamping = 0.9f)
	{
		LTDescr d = pushNewTween(trans.gameObject, Vector3.zero, float.MaxValue, options().setFollow().setTarget(target));
		switch (prop)
		{
		case LeanProp.localPosition:
			d.optional.axis = d.trans.localPosition;
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.bounceOut(d.optional.axis, d.toTrans.localPosition, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping);
				d.trans.localPosition = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.position:
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.bounceOut(d.optional.axis, d.toTrans.position, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping);
				d.trans.position = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.localX:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosX(LeanSmooth.bounceOut(d.trans.localPosition.x, d.toTrans.localPosition.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.localY:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosY(LeanSmooth.bounceOut(d.trans.localPosition.y, d.toTrans.localPosition.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.localZ:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosZ(LeanSmooth.bounceOut(d.trans.localPosition.z, d.toTrans.localPosition.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.x:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosX(LeanSmooth.bounceOut(d.trans.position.x, d.toTrans.position.x, ref d.fromInternal.x, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.y:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosY(LeanSmooth.bounceOut(d.trans.position.y, d.toTrans.position.y, ref d.fromInternal.y, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.z:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosZ(LeanSmooth.bounceOut(d.trans.position.z, d.toTrans.position.z, ref d.fromInternal.z, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping));
			};
			break;
		case LeanProp.scale:
			d.easeInternal = delegate
			{
				d.trans.localScale = LeanSmooth.bounceOut(d.trans.localScale, d.toTrans.localScale, ref d.fromInternal, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping);
			};
			break;
		case LeanProp.color:
			d.easeInternal = delegate
			{
				Color color = LeanSmooth.bounceOut(d.trans.LeanColor(), d.toTrans.LeanColor(), ref d.optional.color, smoothTime, maxSpeed, Time.deltaTime, friction, accelRate, hitDamping);
				d.trans.GetComponent<Renderer>().material.color = color;
			};
			break;
		}
		return d;
	}

	public static LTDescr followLinear(Transform trans, Transform target, LeanProp prop, float moveSpeed)
	{
		LTDescr d = pushNewTween(trans.gameObject, Vector3.zero, float.MaxValue, options().setFollow().setTarget(target));
		switch (prop)
		{
		case LeanProp.localPosition:
			d.optional.axis = d.trans.localPosition;
			d.easeInternal = delegate
			{
				d.optional.axis = LeanSmooth.linear(d.optional.axis, d.toTrans.localPosition, moveSpeed);
				d.trans.localPosition = d.optional.axis + d.toInternal;
			};
			break;
		case LeanProp.position:
			d.easeInternal = delegate
			{
				d.trans.position = LeanSmooth.linear(d.trans.position, d.toTrans.position, moveSpeed);
			};
			break;
		case LeanProp.localX:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosX(LeanSmooth.linear(d.trans.localPosition.x, d.toTrans.localPosition.x, moveSpeed));
			};
			break;
		case LeanProp.localY:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosY(LeanSmooth.linear(d.trans.localPosition.y, d.toTrans.localPosition.y, moveSpeed));
			};
			break;
		case LeanProp.localZ:
			d.easeInternal = delegate
			{
				d.trans.LeanSetLocalPosZ(LeanSmooth.linear(d.trans.localPosition.z, d.toTrans.localPosition.z, moveSpeed));
			};
			break;
		case LeanProp.x:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosX(LeanSmooth.linear(d.trans.position.x, d.toTrans.position.x, moveSpeed));
			};
			break;
		case LeanProp.y:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosY(LeanSmooth.linear(d.trans.position.y, d.toTrans.position.y, moveSpeed));
			};
			break;
		case LeanProp.z:
			d.easeInternal = delegate
			{
				d.trans.LeanSetPosZ(LeanSmooth.linear(d.trans.position.z, d.toTrans.position.z, moveSpeed));
			};
			break;
		case LeanProp.scale:
			d.easeInternal = delegate
			{
				d.trans.localScale = LeanSmooth.linear(d.trans.localScale, d.toTrans.localScale, moveSpeed);
			};
			break;
		case LeanProp.color:
			d.easeInternal = delegate
			{
				Color color = LeanSmooth.linear(d.trans.LeanColor(), d.toTrans.LeanColor(), moveSpeed);
				d.trans.GetComponent<Renderer>().material.color = color;
			};
			break;
		}
		return d;
	}

	public static void addListener(int eventId, Action<LTEvent> callback)
	{
		addListener(tweenEmpty, eventId, callback);
	}

	public static void addListener(GameObject caller, int eventId, Action<LTEvent> callback)
	{
		if (eventListeners == null)
		{
			INIT_LISTENERS_MAX = LISTENERS_MAX;
			eventListeners = new Action<LTEvent>[EVENTS_MAX * LISTENERS_MAX];
			goListeners = new GameObject[EVENTS_MAX * LISTENERS_MAX];
		}
		for (i = 0; i < INIT_LISTENERS_MAX; i++)
		{
			int num = eventId * INIT_LISTENERS_MAX + i;
			if (goListeners[num] == null || eventListeners[num] == null)
			{
				eventListeners[num] = callback;
				goListeners[num] = caller;
				if (i >= eventsMaxSearch)
				{
					eventsMaxSearch = i + 1;
				}
				return;
			}
			if (goListeners[num] == caller && object.Equals(eventListeners[num], callback))
			{
				return;
			}
		}
		Debug.LogError("You ran out of areas to add listeners, consider increasing LISTENERS_MAX, ex: LeanTween.LISTENERS_MAX = " + LISTENERS_MAX * 2);
	}

	public static bool removeListener(int eventId, Action<LTEvent> callback)
	{
		return removeListener(tweenEmpty, eventId, callback);
	}

	public static bool removeListener(int eventId)
	{
		int num = eventId * INIT_LISTENERS_MAX + i;
		eventListeners[num] = null;
		goListeners[num] = null;
		return true;
	}

	public static bool removeListener(GameObject caller, int eventId, Action<LTEvent> callback)
	{
		for (i = 0; i < eventsMaxSearch; i++)
		{
			int num = eventId * INIT_LISTENERS_MAX + i;
			if (goListeners[num] == caller && object.Equals(eventListeners[num], callback))
			{
				eventListeners[num] = null;
				goListeners[num] = null;
				return true;
			}
		}
		return false;
	}

	public static void dispatchEvent(int eventId)
	{
		dispatchEvent(eventId, null);
	}

	public static void dispatchEvent(int eventId, object data)
	{
		for (int i = 0; i < eventsMaxSearch; i++)
		{
			int num = eventId * INIT_LISTENERS_MAX + i;
			if (eventListeners[num] != null)
			{
				if ((bool)goListeners[num])
				{
					eventListeners[num](new LTEvent(eventId, data));
				}
				else
				{
					eventListeners[num] = null;
				}
			}
		}
	}
}

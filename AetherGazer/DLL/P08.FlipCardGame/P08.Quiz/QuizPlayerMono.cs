using System.Collections.Generic;
using UnityEngine;

namespace P08.Quiz;

public sealed class QuizPlayerMono : MonoBehaviour
{
	public float moveSpeed = 2f;

	public float rotateSpeed = 30f;

	public Transform attach_Label;

	public Transform attach_Emoji;

	private Animator m_Animator;

	public QuizPlayer owner;

	public int choose;

	private QClipInfoMono m_QClip;

	private Gesture m_CurGesture = new Gesture();

	private Vector2 m_RemotePos;

	public GameObject modelGo;

	private readonly int ID_MOVE = Animator.StringToHash("move");

	public long PlayerUid => owner.playerUid;

	public bool IsLocalPlayer => owner.isLocalPlayer;

	public List<GestureInfo> GestureInfos => m_QClip.gestureInfos;

	public void GatherComponents()
	{
		m_Animator = GetComponentInChildren<Animator>();
		m_QClip = GetComponentInChildren<QClipInfoMono>();
		m_CurGesture.Stop();
	}

	public GestureInfo FindGestureInfo(int gestureId)
	{
		for (int i = 0; i < GestureInfos.Count; i++)
		{
			GestureInfo gestureInfo = GestureInfos[i];
			if (Animator.StringToHash(gestureInfo.name) == gestureId)
			{
				return gestureInfo;
			}
		}
		return null;
	}

	public void PlayGesture(int gestureId, float crossFade = 0.1f)
	{
		if (gestureId == -1)
		{
			m_CurGesture.Stop();
			return;
		}
		GestureInfo gestureInfo = FindGestureInfo(gestureId);
		if (gestureInfo != null)
		{
			m_CurGesture.Start(gestureId, gestureInfo.duration);
			m_Animator.CrossFadeInFixedTime(m_CurGesture.gestureId, crossFade, 0, 0f);
		}
	}

	public void SetRemotePos(Vector2 remotePos)
	{
		m_RemotePos = remotePos;
	}

	public void SetPlayerPosForce(Vector2 position, Quaternion rotation)
	{
		base.transform.SetPositionAndRotation(new Vector3(position.x, 0f, position.y), rotation);
		SetRemotePos(position);
	}

	public void MoveRemotePlayer()
	{
		float deltaTime = Time.deltaTime;
		bool flag = true;
		if (m_CurGesture.IsPlaying)
		{
			if (m_CurGesture.Update(deltaTime))
			{
				m_Animator.SetFloat(ID_MOVE, 0f);
				flag = false;
			}
			else
			{
				m_CurGesture.Stop();
			}
		}
		if (flag)
		{
			Vector3 forward = new Vector3(m_RemotePos.x, 0f, m_RemotePos.y) - base.transform.position;
			float magnitude = forward.magnitude;
			float value = 0f;
			if (magnitude > 0.05f)
			{
				value = 1f;
				forward.y = 0f;
				Quaternion b = Quaternion.LookRotation(forward);
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, b, Time.deltaTime * rotateSpeed);
				Vector3 position = base.transform.position + moveSpeed * Time.deltaTime * forward.normalized;
				base.transform.position = position;
			}
			m_Animator.SetFloat(ID_MOVE, value, 0.1f, Time.deltaTime);
		}
	}

	public void MoveLocalPlayer(Vector2 input)
	{
		float deltaTime = Time.deltaTime;
		float magnitude = input.magnitude;
		float value = 0f;
		if (m_CurGesture.IsPlaying && !m_CurGesture.Update(deltaTime))
		{
			m_CurGesture.Stop();
			QuizLuaBridge.OnQuizPlayerGestureChanged?.Invoke(PlayerUid, -1);
		}
		if (magnitude > 0.1f)
		{
			Quaternion b = Quaternion.LookRotation(new Vector3(input.x, 0f, input.y));
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, b, Time.deltaTime * rotateSpeed);
			Vector3 inMoveDelta = moveSpeed * Time.deltaTime * base.transform.forward;
			inMoveDelta.y = 0f;
			Vector3 position = base.transform.position;
			if (PositionInMoveArea(position, inMoveDelta, out var newMoveDelta))
			{
				base.transform.position = position + newMoveDelta;
				value = 1f;
			}
			if (m_CurGesture.IsPlaying)
			{
				m_CurGesture.Stop();
				QuizLuaBridge.OnQuizPlayerGestureChanged?.Invoke(PlayerUid, -1);
			}
		}
		m_Animator.SetFloat(ID_MOVE, value, 0.1f, Time.deltaTime);
	}

	public void Update()
	{
		if (IsLocalPlayer)
		{
			Vector2 input = GetInput();
			MoveLocalPlayer(input);
		}
		else
		{
			MoveRemotePlayer();
		}
	}

	private bool PositionInMoveArea(Vector3 curPos, Vector3 inMoveDelta, out Vector3 newMoveDelta)
	{
		newMoveDelta = Vector3.zero;
		if (MonoSingleton<QuizChoiceAreaManagerMono>.Instance != null)
		{
			Bounds moveArea = MonoSingleton<QuizChoiceAreaManagerMono>.Instance.moveArea;
			Vector3 vector = curPos + inMoveDelta;
			if (moveArea.Contains(vector))
			{
				newMoveDelta = inMoveDelta;
				return true;
			}
			Vector3 vector2 = moveArea.ClosestPoint(vector);
			vector2.y = 0f;
			Vector3 normalized = (vector - vector2).normalized;
			Vector3 vector3 = inMoveDelta * 0.98f;
			Vector3 vector4 = Vector3.Dot(vector3, normalized) * normalized;
			newMoveDelta = vector3 - vector4;
			Vector3 point = curPos + newMoveDelta;
			if (moveArea.Contains(point))
			{
				return true;
			}
			return false;
		}
		Debug.LogError("===> [Quiz] QuizChoiceAreaManagerMono is null，没有限制移动区域数据");
		return false;
	}

	private Vector2 GetInput()
	{
		return QuizLuaBridge.GetJoystickInputVec();
	}
}

using System;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.UI;

public class UIRobotMove : MonoBehaviour
{
	public struct Route
	{
		public Vector3 startPos;

		public Vector3 controlPos1;

		public Vector3 controlPos2;

		public Vector3 endPos;

		public float precent;

		public Vector3 Evaluate(float time)
		{
			float num = 1f - time;
			return Mathf.Pow(num, 3f) * startPos + 3f * time * Mathf.Pow(num, 2f) * controlPos1 + 3f * Mathf.Pow(time, 2f) * num * controlPos2 + Mathf.Pow(time, 3f) * endPos;
		}
	}

	[Header("移动终点的时间")]
	public float duration;

	[Header("移动到起点的时间")]
	public float backDuration;

	[Header("最终旋转角度")]
	public Vector3 targetRotate;

	[Header("距离摄像机的偏移")]
	public Vector3 cameraOffset;

	[Header("控制点1在向量中的比例")]
	public float percent1;

	[Header("控制点1绕着向量旋转角度")]
	public float angle1;

	[Header("控制点1的的长度")]
	public float length1;

	[Header("控制点2在向量中的比例")]
	public float percent2;

	[Header("控制点2绕着向量旋转角度")]
	public float angle2;

	[Header("控制点2的的长度")]
	public float length2;

	private Route m_Route;

	public void RobotMove(Action callBack)
	{
		Vector3 position = MonoECS.instance.localPlayer.robotEntity.GetRootTransform().position;
		Vector3 position2 = GameUtility.mainCamera.WorldToViewportPoint(position);
		Vector3 vector = GameUtility.uiCamera.ViewportToWorldPoint(position2);
		GameObject uiRobot = GameUtility.uiRobot;
		if (uiRobot != null)
		{
			uiRobot.transform.position = vector;
			m_Route.startPos = vector;
			uiRobot.transform.localRotation = Quaternion.Euler(new Vector3(0f, 180f, 0f));
			m_Route.precent = 0f;
			uiRobot.SetActive(value: true);
			Vector3 vector2 = GameUtility.uiCamera.transform.position + cameraOffset;
			Quaternion quaternion = Quaternion.FromToRotation(Vector3.right, vector2);
			Quaternion quaternion2 = Quaternion.AngleAxis(angle1, Vector3.right);
			Quaternion quaternion3 = Quaternion.AngleAxis(angle2, Vector3.right);
			Vector3 vector3 = quaternion * quaternion2 * Vector3.up;
			Vector3 vector4 = quaternion * quaternion3 * Vector3.up;
			Vector3 vector5 = Vector3.Lerp(m_Route.startPos, vector2, percent1);
			Vector3 vector6 = Vector3.Lerp(m_Route.startPos, vector2, percent2);
			m_Route.controlPos1 = vector5 + vector3 * length1;
			m_Route.controlPos2 = vector6 + vector4 * length2;
			Move(callBack).Forget();
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public void ResetRobot()
	{
		Back().Forget();
	}

	private async UniTaskVoid Back()
	{
		float p = 0f;
		Transform robotRootTrans = MonoECS.instance.localPlayer.robotEntity.GetRootTransform();
		SystemTime timeSystem = GameManager.timeSystem;
		GameObject uiRobot;
		while (true)
		{
			Vector3 position = robotRootTrans.position;
			Vector3 position2 = GameUtility.mainCamera.WorldToViewportPoint(position);
			Vector3 b = GameUtility.uiCamera.ViewportToWorldPoint(position2);
			float num = timeSystem.globalSpeed * Time.deltaTime;
			p = InterpolationUtility.FixedLerp(p, 1f, num / backDuration);
			uiRobot = GameUtility.uiRobot;
			uiRobot.transform.position = Vector3.Lerp(uiRobot.transform.position, b, p);
			if (Mathf.Approximately(p, 1f))
			{
				break;
			}
			await UniTask.Yield();
		}
		uiRobot.transform.localRotation = Quaternion.Euler(new Vector3(0f, 180f, 0f));
		uiRobot.gameObject.SetActive(value: false);
	}

	private async UniTaskVoid Move(Action callBack)
	{
		SystemTime timeSystem = GameManager.timeSystem;
		while (true)
		{
			float num = timeSystem.globalSpeed * Time.deltaTime;
			m_Route.endPos = GameUtility.uiCamera.transform.position + cameraOffset;
			m_Route.precent = InterpolationUtility.FixedLerp(m_Route.precent, 1f, num / duration);
			GameObject uiRobot = GameUtility.uiRobot;
			uiRobot.transform.position = m_Route.Evaluate(m_Route.precent);
			uiRobot.transform.localRotation = Quaternion.Slerp(uiRobot.transform.localRotation, Quaternion.Euler(targetRotate), m_Route.precent);
			if (Mathf.Approximately(m_Route.precent, 1f))
			{
				break;
			}
			await UniTask.Yield();
		}
		GameUtility.uiRobotEffect.Play();
		callBack?.Invoke();
	}
}

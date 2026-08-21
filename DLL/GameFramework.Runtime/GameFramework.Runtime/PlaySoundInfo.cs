using UnityEngine;

namespace GameFramework.Runtime;

internal sealed class PlaySoundInfo : IReference
{
	private Vector3 m_WorldPosition;

	private object m_UserData;

	public Vector3 WorldPosition => m_WorldPosition;

	public object UserData => m_UserData;

	public PlaySoundInfo()
	{
		m_WorldPosition = Vector3.zero;
		m_UserData = null;
	}

	public static PlaySoundInfo Create(Vector3 worldPosition, object userData)
	{
		PlaySoundInfo playSoundInfo = ReferencePool.Acquire<PlaySoundInfo>();
		playSoundInfo.m_WorldPosition = worldPosition;
		playSoundInfo.m_UserData = userData;
		return playSoundInfo;
	}

	public void Clear()
	{
		m_WorldPosition = Vector3.zero;
		m_UserData = null;
	}
}

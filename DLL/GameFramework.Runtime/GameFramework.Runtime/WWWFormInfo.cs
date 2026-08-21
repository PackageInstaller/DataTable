using UnityEngine;

namespace GameFramework.Runtime;

internal sealed class WWWFormInfo : IReference
{
	private WWWForm m_WWWForm;

	private object m_UserData;

	public WWWForm WWWForm => m_WWWForm;

	public object UserData => m_UserData;

	public WWWFormInfo()
	{
		m_WWWForm = null;
		m_UserData = null;
	}

	public static WWWFormInfo Create(WWWForm wwwForm, object userData)
	{
		WWWFormInfo wWWFormInfo = ReferencePool.Acquire<WWWFormInfo>();
		wWWFormInfo.m_WWWForm = wwwForm;
		wWWFormInfo.m_UserData = userData;
		return wWWFormInfo;
	}

	public void Clear()
	{
		m_WWWForm = null;
		m_UserData = null;
	}
}

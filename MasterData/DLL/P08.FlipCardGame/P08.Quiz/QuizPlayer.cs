using UnityEngine;

namespace P08.Quiz;

public sealed class QuizPlayer
{
	public long playerUid;

	public bool isLocalPlayer;

	public string nickName;

	public int curRoleId;

	public int lastRoleId;

	private QuizPlayerMono m_Character;

	private static readonly int k_CharacterLayer = LayerMask.NameToLayer("Character");

	public void LoadRoot()
	{
		GameObject gameObject = Asset.Instantiate("CharDorm/quiz/QuizPlayer");
		if (gameObject != null && gameObject.TryGetComponent<QuizPlayerMono>(out m_Character))
		{
			m_Character.owner = this;
			if (isLocalPlayer)
			{
				m_Character.gameObject.layer = k_CharacterLayer;
			}
		}
	}

	public void LoadModel(int roleId)
	{
		if (curRoleId == roleId)
		{
			Debug.Log("[Quiz] 已加载相同roleId，跳过不做处理");
			return;
		}
		if (m_Character == null)
		{
			Debug.LogError("[Quiz] LoadRoot first");
			return;
		}
		GameObject gameObject = Asset.Instantiate($"CharDorm/quiz/{roleId}_tpose");
		if (gameObject != null)
		{
			if (m_Character.modelGo != null)
			{
				Vector3 localScale = m_Character.modelGo.transform.localScale;
				PooledAsset.DestroyOrReturn(m_Character.modelGo);
				m_Character.modelGo.transform.localScale = localScale;
			}
			m_Character.modelGo = gameObject;
			m_Character.modelGo.transform.SetParent(m_Character.transform, worldPositionStays: false);
			m_Character.modelGo.transform.localPosition = Vector3.zero;
			m_Character.modelGo.transform.localRotation = Quaternion.identity;
			m_Character.GatherComponents();
			lastRoleId = curRoleId;
			curRoleId = roleId;
			QuizLuaBridge.OnQuizPlayerModelChanged?.Invoke(playerUid, lastRoleId, curRoleId);
		}
		else
		{
			Debug.LogError("[Quiz] SdCharacter not found");
		}
	}

	public void ScaleModel(float scale)
	{
		if (m_Character != null)
		{
			m_Character.transform.localScale = Vector3.one * scale;
		}
	}

	public void DestroyPlayerRoot()
	{
		if (m_Character != null)
		{
			PooledAsset.DestroyOrReturn(m_Character.gameObject);
		}
	}

	public void SyncRemoteGesture(int gestureId, float crossFade = 0.1f)
	{
		if (!isLocalPlayer)
		{
			m_Character.PlayGesture(gestureId, crossFade);
		}
	}

	public Vector2 GetLocalPlayerPos()
	{
		if (isLocalPlayer)
		{
			Vector3 position = m_Character.transform.position;
			return new Vector2(position.x, position.z);
		}
		return default(Vector2);
	}

	public void PlayLocalGesture(int gestureId, float crossFade = 0.1f)
	{
		if (isLocalPlayer)
		{
			m_Character.PlayGesture(gestureId, crossFade);
			QuizLuaBridge.OnQuizPlayerGestureChanged?.Invoke(playerUid, gestureId);
		}
	}

	public GameObject CreateNickName(string uiPath, string nickName)
	{
		if (m_Character != null)
		{
			QNickName qNickName = QNickName.Create(uiPath);
			qNickName.target = m_Character.attach_Label;
			qNickName.txt_nick.text = nickName;
			return qNickName.gameObject;
		}
		return null;
	}

	public void SetNickNameVisible(bool visible)
	{
		if (m_Character != null)
		{
			m_Character.attach_Label.gameObject.SetActive(visible);
		}
	}

	public void SetRemotePos(Vector2 remotePos)
	{
		if (m_Character != null)
		{
			m_Character.SetRemotePos(remotePos);
		}
	}

	public int GetChoose()
	{
		if (m_Character != null)
		{
			return m_Character.choose;
		}
		return 0;
	}

	public Transform GetAttachEmoji()
	{
		if (m_Character != null)
		{
			return m_Character.attach_Emoji;
		}
		return null;
	}

	public void SetPlayerPosForce(Vector2 position, Quaternion rotation)
	{
		if (m_Character != null)
		{
			m_Character.SetPlayerPosForce(position, rotation);
		}
	}

	public GameObject GetPlayerModelGo()
	{
		if (m_Character != null)
		{
			return m_Character.modelGo;
		}
		return null;
	}
}

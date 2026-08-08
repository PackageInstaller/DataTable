using System.Collections.Generic;
using UnityEngine;

namespace P08.Quiz;

public sealed class PlayerManager : Singleton<PlayerManager>
{
	public QuizPlayer LocalPlayer;

	public List<QuizPlayer> PlayerList = new List<QuizPlayer>();

	public void AddLocalPlayer(QuizPlayerInfo playerInfo)
	{
		QuizPlayer quizPlayer = (LocalPlayer = new QuizPlayer
		{
			playerUid = playerInfo.playerUid,
			isLocalPlayer = true,
			nickName = playerInfo.nickName
		});
		PlayerList.Add(quizPlayer);
		quizPlayer.LoadRoot();
		quizPlayer.LoadModel(playerInfo.roleId);
	}

	public void AddRemotePlayer(QuizPlayerInfo playerInfo)
	{
		QuizPlayer quizPlayer = new QuizPlayer
		{
			playerUid = playerInfo.playerUid,
			isLocalPlayer = false,
			nickName = playerInfo.nickName
		};
		PlayerList.Add(quizPlayer);
		quizPlayer.LoadRoot();
		quizPlayer.LoadModel(playerInfo.roleId);
	}

	public void ChangeModel(long playerId, int roleId)
	{
		FindByPlayerId(playerId)?.LoadModel(roleId);
	}

	public void ScaleModel(long playerId, float scale)
	{
		FindByPlayerId(playerId)?.ScaleModel(scale);
	}

	public void RestoreLastModel(long playerId)
	{
		QuizPlayer quizPlayer = FindByPlayerId(playerId);
		quizPlayer?.LoadModel(quizPlayer.lastRoleId);
	}

	public QuizPlayer FindByPlayerId(long playerId)
	{
		for (int i = 0; i < PlayerList.Count; i++)
		{
			QuizPlayer quizPlayer = PlayerList[i];
			if (quizPlayer.playerUid == playerId)
			{
				return quizPlayer;
			}
		}
		return null;
	}

	public void RemovePlayerById(long playerId)
	{
		QuizPlayer quizPlayer = FindByPlayerId(playerId);
		if (quizPlayer != null)
		{
			quizPlayer.DestroyPlayerRoot();
			PlayerList.Remove(quizPlayer);
		}
	}

	public void SetRemotePlayerPos(long playerId, float x, float z)
	{
		FindByPlayerId(playerId)?.SetRemotePos(new Vector2(x, z));
	}

	public void SetPlayerPosForce(long playerId, Vector3 position, Quaternion rotation)
	{
		FindByPlayerId(playerId)?.SetPlayerPosForce(position, rotation);
	}

	public void SetAllPlayersNickNameVisible(bool visible)
	{
		foreach (QuizPlayer player in PlayerList)
		{
			player.SetNickNameVisible(visible);
		}
	}

	public void DoDestroy()
	{
		for (int i = 0; i < PlayerList.Count; i++)
		{
			PlayerList[i]?.DestroyPlayerRoot();
		}
		PlayerList.Clear();
		LocalPlayer = null;
	}
}

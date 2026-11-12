using UnityEngine;

[CreateAssetMenu(fileName = "TeamConfig", menuName = "BootConfig/TeamConfig", order = 11)]
public class BootTeamConfig : ScriptableObject
{
	[SerializeField]
	private GameTeamConfig gameTeamConfig;

	public GameTeamConfig GameTeamConfig => gameTeamConfig;
}

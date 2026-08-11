using TMPro;
using UnityEngine;

public class PlayerDataView : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI configId;

	public void InitView(VerificationPlayerData playerData)
	{
		((TMP_Text)configId).text = playerData.ConfigId;
	}
}

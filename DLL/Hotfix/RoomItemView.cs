using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class RoomItemView : MonoBehaviour
{
	public GameObject playDataViewItem;

	public Transform playerDataRoot;

	[SerializeField]
	private TextMeshProUGUI roomId;

	[SerializeField]
	private Button downLoadPlayerData;

	[SerializeField]
	private Button downLoadRoomData;

	[SerializeField]
	private Button startVerification;

	[SerializeField]
	private Button delRoomData;

	[SerializeField]
	private Image progress;

	private RoomData _roomData;

	private List<GameObject> _playerDataItemList = new List<GameObject>();

	public void InitView(RoomData roomData)
	{
		_roomData = null;
		for (int i = 0; i < _playerDataItemList.Count; i++)
		{
			Object.Destroy(_playerDataItemList[i]);
		}
		_playerDataItemList.Clear();
		_roomData = roomData;
		((TMP_Text)roomId).text = roomData.RoomId;
		for (int j = 0; j < roomData.PlayerDataList.Count; j++)
		{
			VerificationPlayerData playerData = roomData.PlayerDataList[j];
			GameObject gameObject = Object.Instantiate(playDataViewItem);
			PlayerDataView component = gameObject.GetComponent<PlayerDataView>();
			_playerDataItemList.Add(gameObject);
			component.InitView(playerData);
			gameObject.transform.SetParent(playerDataRoot);
		}
	}

	public void OnEnable()
	{
		downLoadPlayerData.onClick.AddListener(DownLoadPlayerData);
		downLoadRoomData.onClick.AddListener(DownLoadRoomData);
		startVerification.onClick.AddListener(StartVerification);
		delRoomData.onClick.AddListener(DelRoomData);
	}

	public void Update()
	{
		if (_roomData != null)
		{
			_roomData.UpdateData();
			progress.fillAmount = _roomData.Progress;
		}
	}

	private void DownLoadPlayerData()
	{
		_roomData.DownLoadPlayerFile();
	}

	private void DownLoadRoomData()
	{
		_roomData.DownloadRoomData();
	}

	private void StartVerification()
	{
		_roomData.StartVerification();
		progress.gameObject.SetActive(value: true);
	}

	private void DelRoomData()
	{
		_roomData.DelRoomData();
		Clear();
	}

	private void Clear()
	{
		for (int i = 0; i < _playerDataItemList.Count; i++)
		{
			Object.Destroy(_playerDataItemList[i]);
		}
		_roomData = null;
		progress.gameObject.SetActive(value: false);
	}

	public void OnDisable()
	{
		downLoadPlayerData.onClick.RemoveListener(DownLoadPlayerData);
		downLoadRoomData.onClick.RemoveListener(DownLoadRoomData);
		startVerification.onClick.RemoveListener(StartVerification);
		delRoomData.onClick.RemoveListener(DelRoomData);
	}
}

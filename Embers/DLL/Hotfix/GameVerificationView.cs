using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

public class GameVerificationView : MonoBehaviour
{
	[SerializeField]
	private LoopGridView roomList;

	[SerializeField]
	private Button refreshBtn;

	private GameVerificationViewModel _verificationViewModel;

	public void Start()
	{
		_verificationViewModel = new GameVerificationViewModel(RefreshRoomView);
		roomList.InitGridView(_verificationViewModel.RoomList.Count, OnGetMultiRoomInviteItemByIndex);
	}

	private void RefreshRoomView()
	{
		roomList.SetListItemCount(_verificationViewModel.RoomList.Count);
		roomList.RefreshAllShownItem();
	}

	public void OnEnable()
	{
		refreshBtn.onClick.AddListener(RefreshRoomData);
	}

	public void OnDisable()
	{
		refreshBtn.onClick.RemoveListener(RefreshRoomData);
	}

	private void RefreshRoomData()
	{
		if (_verificationViewModel == null)
		{
			Debug.LogError("刷新房间失败：_verificationViewModel == null");
			return;
		}
		_verificationViewModel.RefreshRoom();
		roomList.SetListItemCount(_verificationViewModel.RoomList.Count);
		roomList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetMultiRoomInviteItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		RoomData roomData = _verificationViewModel.RoomList[index];
		if (roomData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("RoomItem");
		loopGridViewItem.GetComponent<RoomItemView>().InitView(roomData);
		return loopGridViewItem;
	}
}

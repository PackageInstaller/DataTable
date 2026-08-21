using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IRedPointService
{
	UniTask<bool> RequestServerRedPoints();

	void InitRedPointDatas();

	void Publish(RedPointMessageEnum msgType, bool redState);

	IMessenger GetMessager();

	void AddTalentTree(Action action);

	void RemoveTalentTree();

	bool GetShopRedByShopPosition(ShopGoodItemData.ShopPosition shopPosition);

	List<RedPointSave> GetRedPoint(string systemName, bool forceLoading = false);

	List<RedPointSave> GetRedPoint(RedPointLocalSaveKeys key, bool forceLoading = false);

	bool GetRedPointDaily(string systemName);

	void SaveRedPointDaily(string systemName);

	void CancelUserRead(ServerReadEnum serverRead);

	bool GetUserRead(ServerReadEnum serverRead);

	bool GetServerRed(ServerRedType serverRedType);

	bool GetServerRed(List<ServerRedType> serverRedTypes);

	void SetServerRed(ServerRedType serverRedType, bool red);

	string SaveRedPoint(List<RedPointSave> obj, string systemName);

	string SaveRedPoint(List<RedPointSave> obj, RedPointLocalSaveKeys key);
}

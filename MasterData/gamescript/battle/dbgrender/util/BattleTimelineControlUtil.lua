local GameObject = CS.UnityEngine.GameObject
local BattleTimelineControlUtil = {}

function BattleTimelineControlUtil.ShowAwakerSkillBtnEffect(strParam)
  local strArr = string.split(strParam, ";")
  local index = tonumber(strArr[1])
  local resPath = strArr[2]
  local parentName = strArr[3]
  local siblingIndex = tonumber(strArr[4])
  local prefab = ResLoadMgr.LoadAsset(resPath, bg.battleScene)
  local battlePanel = UIManager.Instance:GetWindow(Urls.DbgBattlePanel)
  local awakerItemCom = battlePanel.ultiSkillPanel.items[index]
  local uiParentTf = awakerItemCom.ui[parentName].transform
  if nil ~= prefab then
    local copy = GameObject.Instantiate(prefab)
    if 0 == siblingIndex then
      copy.transform:SetParent(uiParentTf, false)
    else
      uiParentTf = uiParentTf.parent
      copy.transform:SetParent(uiParentTf, false)
      if siblingIndex < 0 then
        copy.transform:SetAsFirstSibling()
      else
        copy.transform:SetAsLastSibling()
      end
    end
    bg.battleRender:PerformWithDelay(5, function()
      GameObject.Destroy(copy)
    end)
  else
    Logger.Error("ShowAwakerSkillBtnEffect is nil")
  end
end

function BattleTimelineControlUtil.RecordPrefabs(key, copy)
  local temp = BattleTimelineControlUtil.TempPrefabs
  if nil == temp then
    temp = {}
    BattleTimelineControlUtil.TempPrefabs = temp
  end
  temp[key] = copy
end

function BattleTimelineControlUtil.ClearAssets(key)
  local temp = BattleTimelineControlUtil.TempPrefabs
  if nil == temp then
    return
  end
  local copy = temp[key]
  temp[key] = nil
  if copy then
    GameObject.Destroy(copy)
    Logger.Error("Clear : ", key)
  end
end

function BattleTimelineControlUtil.ShowKeeperSkillBtnEffect(strParam)
  local strArr = string.split(strParam, ";")
  local resPath = strArr[1]
  local parentName = strArr[2]
  local siblingIndex = tonumber(strArr[3])
  local prefab = ResLoadMgr.LoadAsset(resPath, bg.battleScene)
  local battlePanel = UIManager.Instance:GetWindow(Urls.DbgBattlePanel)
  local uiParentTf = battlePanel.keeperSkillCom.ui[parentName].transform
  if nil ~= prefab then
    local copy = GameObject.Instantiate(prefab)
    if 0 == siblingIndex then
      copy.transform:SetParent(uiParentTf, false)
    else
      uiParentTf = uiParentTf.parent
      copy.transform:SetParent(uiParentTf, false)
      if siblingIndex < 0 then
        copy.transform:SetAsFirstSibling()
      else
        copy.transform:SetAsLastSibling()
      end
    end
    bg.battleRender:PerformWithDelay(5, function()
      GameObject.Destroy(copy)
    end)
  else
    Logger.Error("ShowKeeperSkillBtnEffect is nil")
  end
end

return BattleTimelineControlUtil

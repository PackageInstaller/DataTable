local base = UIBaseWindow
local UISnakeGameRank = class("UISnakeGameRank", base)
local UINSnakeGameRankItem = require("Game.TinyGames.Snake.UI.UINSnakeGameRankItem")

function UISnakeGameRank:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickReturn, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_BackPause, self, self._HideAndBack)
  self.itemDic = {}
  self.ui.rankList.onChangeItem = BindCallback(self, self.__OnChangeItem, mineGrade)
  self.ui.rankList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.resloader = CS.ResLoader.Create()
end

function UISnakeGameRank:RefreshSnakeGameRank(allFriendData, mineGrade, rankIndex)
  self.allFriendDataList = allFriendData
  self.ui.tex_UID.text = tostring(PlayerDataCenter.inforData:GetUserUID())
  self.ui.tex_PlayerName.text = PlayerDataCenter.inforData:GetUserName()
  self.ui.tex_Rank:SetIndex(0, tostring(rankIndex))
  self.ui.tex_Score.text = tostring(mineGrade.score)
  self.ui.rankList.totalCount = #self.allFriendDataList
  self.ui.rankList:RefillCells()
  local picPath
  if PlayerDataCenter.inforData:GetSex() then
    picPath = PathConsts:GetResImagePath("Activity/ActSummer2022/UI_ActSum22DollF.png")
  else
    picPath = PathConsts:GetResImagePath("Activity/ActSummer2022/UI_ActSum22DollM.png")
  end
  self.ui.img_CmderPic.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_CmderPic.gameObject:SetActive(true)
    self.ui.img_CmderPic.texture = texture
  end)
end

function UISnakeGameRank:SetSnakeRankHisHighScore(num)
  if num then
    self.ui.tex_BestScore.gameObject:SetActive(true)
    self.ui.tex_BestScore:SetIndex(0, tostring(num))
  else
    self.ui.tex_BestScore.gameObject:SetActive(false)
  end
end

function UISnakeGameRank:__OnChangeItem(mineGrade, go, index)
  local item = self.itemDic[go]
  local itemData = self.allFriendDataList[index + 1]
  local isMine = mineGrade == itemData
  item:InitSnakeRankItem(itemData, index + 1, isMine)
end

function UISnakeGameRank:__OnInstantiateItem(go)
  local item = UINSnakeGameRankItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UISnakeGameRank:_OnClickReturn()
  self:Delete()
end

function UISnakeGameRank:_HideAndBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UISnakeGameRank:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UISnakeGameRank

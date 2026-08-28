local View = require("UINotice_beforeLogin/UINotice_beforeLoginView")
local DataModel = require("UINotice_beforeLogin/UINotice_beforeLoginDataModel")
local Controller = {}

function Controller:Init()
  Controller:ClickTopTab(1)
end

function Controller:LeftDetail(row)
  if row == nil then
    return
  end
  local Group_main = View.Group_Newinfo.Group_main
  Group_main.Group_Title.Txt_Title:SetText(row.left_titile or "")
  Group_main.Group_Title.Txt_Time:SetText(row.left_time or "")
  local isNonBreakingSpaceUsed
  if GameSetting.isNonBreakingSpaceUsed ~= nil then
    isNonBreakingSpaceUsed = GameSetting.isNonBreakingSpaceUsed
    GameSetting.isNonBreakingSpaceUsed = false
  end
  Group_main.Group_details.ScrollView_.Viewport.Content.TextHyperlink_Main:SetText(row.content)
  if GameSetting.isNonBreakingSpaceUsed ~= nil then
    GameSetting.isNonBreakingSpaceUsed = isNonBreakingSpaceUsed
  end
  Group_main.Group_details.ScrollView_.Viewport.Content.self:SetLocalPositionY(0)
end

function Controller:ClickRightTab(index)
  if DataModel.RightIndex and index == DataModel.RightIndex and DataModel.IsRefresh == false then
    return
  end
  DataModel.RightIndex = index
  View.Group_Newinfo.Group_main.ScrollGrid_.grid.self:RefreshAllElement()
  local row = DataModel.RightList[index]
  Controller:LeftDetail(row)
  DataModel.IsRefresh = false
end

function Controller:LeftPicDetail(row)
  local Img_Big = View.Group_Newinfo.Group_Pic.Group_big.Img_Big
  NoticeManager:SetAsyncTexture(row.bigImg, function(texture2D)
    if UIManager:GetPanel("UI/Notice/Notice_beforeLogin") and UIManager:GetPanel("UI/Notice/Notice_beforeLogin").IsActive then
      Img_Big:SetTexture2D(texture2D)
    end
  end, row.isNeedDown)
end

function Controller:ClickTopTab(index)
  if DataModel.TopIndex and index == DataModel.TopIndex then
    return
  end
  View.Group_Newinfo.Group_btn.Group_notice.Btn_notice.Group_off.self:SetActive(index ~= 2)
  View.Group_Newinfo.Group_btn.Group_notice.Btn_notice.Group_on.self:SetActive(index == 2)
  View.Group_Newinfo.Group_btn.Group_pic.Btn_pic.Group_off.self:SetActive(index ~= 1)
  View.Group_Newinfo.Group_btn.Group_pic.Btn_pic.Group_on.self:SetActive(index == 1)
  View.Group_Newinfo.Group_main.self:SetActive(index == 2)
  View.Group_Newinfo.Group_Pic.self:SetActive(index == 1)
  if index == 1 then
    if DataModel.PicGridHave == false then
      View.Group_Newinfo.Group_Pic.Group_small.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.LeftList))
      View.Group_Newinfo.Group_Pic.Group_small.ScrollGrid_.grid.self:RefreshAllElement()
      DataModel.PicGridHave = true
    end
    View.Group_Newinfo.Group_Pic.Group_small.ScrollGrid_.grid.self:MoveToPos(DataModel.PicRightIndex or 1)
    local Group_big = View.Group_Newinfo.Group_Pic.Group_big
    NoticeManager:SetAsyncTexture(DataModel.LeftImgBig, function(texture2D)
      if UIManager:GetPanel("UI/Notice/Notice_beforeLogin") and UIManager:GetPanel("UI/Notice/Notice_beforeLogin").IsActive then
        Group_big.Img_Big:SetTexture2D(texture2D)
      end
    end, false)
    Group_big.Img_Big.Txt_time:SetText(DataModel.LeftImgTime)
    Group_big.Img_Big.Txt_title:SetText(DataModel.LeftImgTitle)
    Group_big.Img_Big.Txt_time:SetActive(DataModel.LeftImgTime ~= "")
    Group_big.Img_Big.Txt_title:SetActive(DataModel.LeftImgTitle ~= "")
  end
  if index == 2 then
    if DataModel.MainGridHave == false then
      View.Group_Newinfo.Group_main.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.RightList))
      View.Group_Newinfo.Group_main.ScrollGrid_.grid.self:RefreshAllElement()
      DataModel.MainGridHave = true
    end
    View.Group_Newinfo.Group_main.ScrollGrid_.grid.self:MoveToPos(DataModel.RightIndex or 1)
    Controller:ClickRightTab(DataModel.RightIndex or 1)
  end
end

function Controller:ImgPageJump(url, webUrl, jumpUrlId)
  if webUrl then
    CS.UnityEngine.Application.OpenURL(webUrl)
    return
  end
  if url == "" then
    return
  end
  if MainManager.bgSceneName ~= "Main" then
    CommonTips.OpenTips(80609574)
    return
  end
  if url == "UI/Store/Store" then
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      UIManager:CloseSpecialUI("UI/Notice/Notice_beforeLogin")
      UIManager:Open(url, Json.encode(json))
    end)
    return
  end
  if url == "UI/Mail/Mail" then
    local funcCommon = require("Common/FuncCommon")
    if funcCommon.FuncActiveCheck(117) then
      Net:SendProto("mail.get", function(json)
        PlayerData.ServerData.mails = json.mails
        UIManager:CloseSpecialUI("UI/Notice/Notice_beforeLogin")
        UIManager:Open("UI/Mail/Mail")
      end)
    end
    return
  end
  if url == "UI/BP_Quest/BattlePass_Quest" then
    local isOpen, currentBattleId = PlayerData:GetNowPassData()
    local BattlePassDataModel = require("UIBattlePass_Quest/UIBattlePass_QuestDataModel")
    if PlayerData.CurrentBattleId ~= nil and PlayerData.CurrentBattleId ~= currentBattleId or PlayerData.CurrentBattleId == nil or BattlePassDataModel:GetRefreshBattlePass() then
      Net:SendProto("battle_pass.bp_info", function(json)
        if json.quests then
          for k, v in pairs(json.quests) do
            PlayerData.ServerData.quests[k] = v
          end
        end
        UIManager:CloseSpecialUI("UI/Notice/Notice_beforeLogin")
        UIManager:Open("UI/BP_Quest/BattlePass_Quest")
      end)
    else
      Net:SendProto("quest.list", function(json)
        PlayerData.ServerData.quests = json.quests
        UIManager:CloseSpecialUI("UI/Notice/Notice_beforeLogin")
        UIManager:Open("UI/BP_Quest/BattlePass_Quest")
      end, EnumDefine.QuestListDefine.All)
    end
    return
  end
  UIManager:CloseSpecialUI("UI/Notice/Notice_beforeLogin")
  UIManager:Open(url)
end

return Controller

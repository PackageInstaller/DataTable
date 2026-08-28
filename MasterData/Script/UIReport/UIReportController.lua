local View = require("UIReport/UIReportView")
local DataModel = require("UIReport/UIReportDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

local function SetCanvasGroupShow(obj, isShow)
  local canvasGroup = obj:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = isShow and 1 or 0
  canvasGroup.interactable = isShow
  canvasGroup.blocksRaycasts = isShow
end

function Controller:Init()
  DataModel.Init()
  local cells = View.ScrollGrid_List.grid.self.Cells
  local count = cells.Count
  for i = 0, count - 1 do
    SetCanvasGroupShow(cells[i], false)
  end
  View.ScrollGrid_List.grid.self:SetDataCount(#DataModel.decodeParams)
  View.ScrollGrid_List.grid.self:MoveToTop()
  View.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:RefreshElement(element, elementIndex)
  SetCanvasGroupShow(element.self, true)
  local info = DataModel.decodeParams[elementIndex]
  local ca = PlayerData:GetFactoryData(info.id)
  element.Group_Item.Txt_Name:SetText(ca.name)
  element.Group_Item.Img_Icon:SetSprite(ca.onPath)
  element.Group_Item.Group_Time.Txt_Time:SetText(info.time)
  element.Group_Item.StaticGrid_RoleList.grid.self:SetParentParam(elementIndex)
  element.Group_Item.StaticGrid_RoleList.grid.self:RefreshAllElement()
  element.Group_Item.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.Group_Item.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewardList)
  element.Group_Item.ScrollGrid_Reward.grid.self:RefreshAllElement()
end

function Controller:RefreshRoleElement(element, elementIndex)
  local info = DataModel.decodeParams[tonumber(element.ParentParam)]
  local roleId = info.roles[elementIndex]
  if roleId and 0 < roleId then
    local serverRoleInfo = PlayerData.ServerData.roles[tostring(roleId)]
    local unitCA = PlayerData:GetFactoryData(roleId)
    local skinId = serverRoleInfo.current_skin and serverRoleInfo.current_skin[1] or ""
    if string.nilorempty(skinId) then
      skinId = unitCA.viewId
    end
    local unitViewCA = PlayerData:GetFactoryData(skinId)
    element.Spine_Role:SetData(unitViewCA.resDir)
    element.Txt_Grade:SetText(string.format(GetText(80608600), serverRoleInfo.lv))
  end
end

function Controller:RefreshRewardElement(element, elementIndex)
  local info = DataModel.decodeParams[tonumber(element.ParentParam)]
  local rewardInfo = info.rewardList[elementIndex]
  BtnItem:SetItem(element.Group_Item, {
    id = rewardInfo.id
  })
  element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
  local mulRatio = 1
  if info.isRewardUp then
    mulRatio = mulRatio * DataModel.weekDayCoefficient
  end
  if info.isBattlePassUp then
    local pass_ratio = 1
    for _, passInfo in ipairs(PlayerData:GetActiveBattlePassList()) do
      local passData = PlayerData:GetBattlePass(passInfo.kind)
      if passData and passData.pass_type and passData.pass_type == 2 then
        pass_ratio = pass_ratio + DataModel.battlePassCoefficient
      end
    end
    mulRatio = mulRatio * pass_ratio
  end
  element.Group_Num.Txt_Num:SetText(math.floor(rewardInfo.num * mulRatio))
  element.Img_Tips:SetActive(info.isRewardUp or info.isBattlePassUp)
end

function Controller:ClickRewardItem(str)
  local id = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(id)
end

function Controller:Close()
  UIManager:GoBack()
end

function Controller:AgainEntrust()
  local entrustDM = require("UIEntrust/UIEntrustDataModel")
  if entrustDM.curEntrustedCount + #DataModel.decodeParams > entrustDM.maxEntrustedCount then
    Controller:Close()
    CommonTips.OpenTips(80611967)
    return
  end
  local cacheRoles = {}
  local cacheEntrustId = {}
  local ids = ""
  local timeIdxs = ""
  local roles = ""
  local isCheckSame = false
  
  local function checkSameRole(roleId)
    if roleId <= 0 or cacheRoles[roleId] ~= nil then
      isCheckSame = true
      return true
    end
    cacheRoles[roleId] = 1
    return false
  end
  
  for i, v in ipairs(DataModel.decodeParams) do
    cacheEntrustId[tonumber(v.id)] = 1
    if ids == "" then
      ids = v.id
      timeIdxs = v.timeIdx - 1
      local roleStr = ""
      for i1, roleId in ipairs(v.roles) do
        if checkSameRole(roleId) then
          break
        end
        if roleStr == "" then
          roleStr = roleId
        else
          roleStr = roleStr .. "," .. roleId
        end
      end
      roles = roleStr
    else
      ids = ids .. "," .. v.id
      timeIdxs = timeIdxs .. "," .. v.timeIdx - 1
      local roleStr = ""
      for i1, roleId in ipairs(v.roles) do
        if checkSameRole(roleId) then
          break
        end
        if roleStr == "" then
          roleStr = roleId
        else
          roleStr = roleStr .. "," .. roleId
        end
      end
      roles = roles .. "|" .. roleStr
    end
    if isCheckSame then
      break
    end
  end
  if not isCheckSame then
    for k, v in pairs(PlayerData.ServerData.entrust) do
      if cacheEntrustId[tonumber(k)] == nil then
        for i, roleId in ipairs(v.roles) do
          if checkSameRole(tonumber(roleId)) then
            isCheckSame = true
            break
          end
        end
      end
      if isCheckSame then
        break
      end
    end
  end
  if isCheckSame then
    Controller:Close()
    CommonTips.OpenTips(80608602)
    return
  end
  Net:SendProto("building.entrust", function(json)
    CommonTips.OpenTips(80608597)
    for k, v in pairs(json.entrust) do
      PlayerData.ServerData.entrust[k] = v
    end
    UIManager:GoBack(false)
    View.self:Confirm()
  end, ids, timeIdxs, roles)
end

return Controller

local DepotInfoSourceCtrl = class("DepotInfoSourceCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local RapidJson = require("rapidjson")
DepotInfoSourceCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Info_Source"
  },
  goJump = {},
  trBg = {sNodeName = "rtBg", sComponentName = "Transform"}
}
DepotInfoSourceCtrl._mapEventConfig = {}

function DepotInfoSourceCtrl:Refresh(nId)
  self.nId = nId
  local mapItem = ConfigTable.GetData_Item(nId)
  local tbJumpTo = mapItem.JumpTo
  if #tbJumpTo == 0 then
    self.gameObject:SetActive(false)
    return
  end
  self:RemoveAllBtn()
  self.tbJumptoData = {}
  for _, nJumptoId in ipairs(tbJumpTo) do
    local mapJumpTo = ConfigTable.GetData("JumpTo", nJumptoId)
    if mapJumpTo ~= nil then
      if mapJumpTo.Type == GameEnum.jumpType.ComCYO then
        local mapProduceCfg = ConfigTable.GetData("ProduceHelper", nId)
        if mapProduceCfg ~= nil then
          local tbComCYO = mapProduceCfg.ComCYOIds
          for _, v in ipairs(tbComCYO) do
            local nCount = PlayerData.Item:GetItemCountByID(v)
            if 0 < nCount then
              local itemCfgData = ConfigTable.GetData_Item(v, true)
              if itemCfgData ~= nil then
                local mapAfter = clone(mapJumpTo)
                mapAfter.Desc = string.format(mapAfter.Desc, itemCfgData.Title)
                mapAfter.Param = {v}
                table.insert(self.tbJumptoData, mapAfter)
              end
            end
          end
        end
      else
        table.insert(self.tbJumptoData, mapJumpTo)
      end
    end
  end
  for i, mapJumpTo in ipairs(self.tbJumptoData) do
    local goJumpto = instantiate(self._mapNode.goJump, self._mapNode.trBg)
    goJumpto:SetActive(true)
    local btnComp = goJumpto.transform:Find("btnJump"):GetComponent("Button")
    table.insert(self.tbGoJumpto, btnComp)
    local func_Handler = ui_handler(self, self.OnBtnClick_JumpTo, btnComp, i)
    btnComp.onClick:AddListener(func_Handler)
    local imgIconJumpto = goJumpto.transform:Find("btnJump/AnimRoot/imgIcon"):GetComponent("Image")
    local txtDesc = goJumpto.transform:Find("btnJump/AnimRoot/txtDesc"):GetComponent("TMP_Text")
    local goArrow = goJumpto.transform:Find("btnJump/AnimRoot/imgArrow").gameObject
    if mapJumpTo.Icon == nil then
      mapJumpTo.Icon = ""
    end
    self:SetPngSprite(imgIconJumpto, mapJumpTo.Icon)
    NovaAPI.SetImageNativeSize(imgIconJumpto)
    NovaAPI.SetTMPText(txtDesc, mapJumpTo.Desc)
    if mapJumpTo.Type == GameEnum.jumpType.Text then
      btnComp.interactable = false
      goArrow:SetActive(false)
    else
      btnComp.interactable = true
      goArrow:SetActive(true)
    end
  end
end

function DepotInfoSourceCtrl:RemoveAllBtn()
  if self.tbGoJumpto == nil then
    return
  end
  for _, btnComp in pairs(self.tbGoJumpto) do
    btnComp.onClick:RemoveAllListeners()
  end
  self.tbGoJumpto = {}
  delChildren(self._mapNode.trBg)
end

function DepotInfoSourceCtrl:OnBtnClick_JumpTo(_, nIndex)
  JumpUtil.JumpTo(self.tbJumptoData[nIndex].Id, self.tbJumptoData[nIndex].Param, self.nId)
end

function DepotInfoSourceCtrl:Awake()
  self.tbGoJumpto = {}
end

function DepotInfoSourceCtrl:OnEnable()
end

function DepotInfoSourceCtrl:OnDisable()
  self:RemoveAllBtn()
end

function DepotInfoSourceCtrl:OnDestroy()
end

return DepotInfoSourceCtrl

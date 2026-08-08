local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_itemInfo = {}
local m_id
local m_gots = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  LU.Bind(REF.PreviewContent, {
    updateRow = UpdateWidget
  })
end

function SetBoxId(boxId)
  if boxId then
    m_itemInfo = {}
    m_id = boxId
    local itemIds = PB.all("DrawBox")
    for i = 1, #itemIds do
      if itemIds[i].itemId == boxId then
        local reward = {}
        reward.type = itemIds[i].drawBoxRes.type
        reward.id = itemIds[i].drawBoxRes.id
        reward.count = itemIds[i].drawBoxRes.count
        reward.prarm = itemIds[i].drawBoxRes.param
        table.insert(m_itemInfo, reward)
      end
    end
    this:GameRequest("/fci/item-drawbox/" .. boxId .. "/"):Get(function(result)
      m_gots = result.gotIndex
      LU.Set(REF.PreviewContent, #m_itemInfo)
    end)
    REF.LabelDescribleTitle.UILabel.text = WU.GetString("ItemName_" .. boxId)
  end
end

function OnCancelClick()
  WU.RecycleWindow(this)
end

function OnButtonConfirm()
  this:GameRequest("fci/itemuse/"):Post({id = m_id, count = 1}, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange, function()
      WU.RecycleWindow(this)
    end)
  end)
end

function UpdateWidget(refRow, wrapIndex, realIndex)
  if m_id then
    local rewardInfo = m_itemInfo[realIndex + 1]
    if rewardInfo then
      refRow["$$SetData"](rewardInfo.type, rewardInfo.id, fif(rewardInfo.count == 0, "?", rewardInfo.count))
      if m_gots ~= nil then
        for i = 1, #m_gots do
          if m_gots[i] == realIndex then
            refRow["$$SetTips"]("received")
            break
          end
        end
      end
      return
    end
  end
  refRow["$$ClearSlot"]()
end

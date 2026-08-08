local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_call
local m_count = 0
local m_id = 0

function ResetState()
end

function SetClickCallback(call)
  m_call = call
end

function Awake()
  WU.BindButtonEvent(REF.SpriteIconBG, function()
    if m_call then
      m_call()
    end
  end)
end

function SetData(id, count)
  ResetState()
  m_count = count
  m_id = id
  local itemInfo = PB.get("ItemInfo", id)
  REF.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
  if itemInfo then
    if itemInfo.type == PB.enum.ItemType.Material then
    elseif itemInfo.type == PB.enum.ItemType.Consumable then
    elseif itemInfo.type == PB.enum.ItemType.ActorChip then
      REF.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
    elseif itemInfo.type == PB.enum.ItemType.Max then
    end
  else
    error("ItemInfo", "Cannot find ItemInfo by id: " .. tostring(id))
  end
  SetLabel(count)
end

function SetIconBg(spriteName)
  REF.SpriteIconBG.UISprite.spriteName = spriteName
end

function SetLabel(text)
  REF.LabelBottomRight.UIHtmlLabel.text = text
end

function SetItem(item)
  ResetState()
  SetData(item.id, item.count)
  REF.SpriteNew.gameObject:SetActive(item.isNew)
end

function ShowCustom(data)
  REF.SpriteIcon.UISprite.graify = data.gray ~= nil and data.gray
end

local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_data

function Start()
  WU.BindButtonEvent(REF["$"], OnSlotClick)
end

function SetData(data)
  if data ~= nil then
    m_data = data
    WU.SetActive(REF.NodeSkin, false)
    WU.SetActive(REF.ArmName, false)
    WU.SetActive(REF.ActorName, false)
    WU.SetActive(REF.SpriteQualityBG, false)
    WU.SetActive(REF.SpriteQualityBGArm, false)
    WU.SetActive(REF.TextureActorPortrait, false)
    WU.SetActive(REF.TextureArmPortrait, false)
    if data.good.type == PB.enum.ResourceType.ResActor then
      WU.SetActive(REF.SpriteActorType, true)
      WU.SetActive(REF.ActorName, true)
      WU.SetActive(REF.SpriteQualityBG, true)
      WU.SetActive(REF.TextureActorPortrait, true)
      local actorQuality, actorStar = AU.CheckActorStarRandom(data.good.id, data.good.param)
      m_data.good.quality = actorQuality
      m_data.good.star = actorStar
      REF.SpriteQualityBG.UISprite.spriteName = "gacha_role_" .. actorQuality
      REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. data.good.id
      local actorConfig = PB.get("ActorConfig", data.good.id)
      if actorConfig then
        REF.TextureActorPortrait.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
        local rect = REF.TextureActorPortrait.UITexture.uvRect
        rect.x = -actorConfig.portraitOffsetX / REF.TextureActorPortrait.UITexture.width
        rect.y = -actorConfig.portraitOffsetY / REF.TextureActorPortrait.UITexture.height
        REF.TextureActorPortrait.UITexture.uvRect = rect
        REF.LabelName.UILabel.text = WU.GetString("ActorName_" .. data.good.id)
        REF.SpriteSubActor.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Sub)
      end
    elseif data.good.type == PB.enum.ResourceType.ResActorSkin then
      WU.SetActive(REF.NodeSkin, true)
      WU.SetActive(REF.SpriteActorType, false)
      WU.SetActive(REF.ActorName, true)
      WU.SetActive(REF.SpriteQualityBG, true)
      WU.SetActive(REF.TextureActorPortrait, true)
      local resSkin = PB.get("ActorSkin", data.good.id)
      if resSkin then
        local actorConfig, paletteIndex = FindActorConfig(resSkin)
        if actorConfig and paletteIndex then
          REF.SpriteQualityBG.UISprite.spriteName = "gacha_role_" .. resSkin.quality
          REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actorConfig.id
          REF.TextureActorPortrait.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
          local rect = REF.TextureActorPortrait.UITexture.uvRect
          rect.x = -actorConfig.portraitOffsetX / REF.TextureActorPortrait.UITexture.width
          rect.y = -actorConfig.portraitOffsetY / REF.TextureActorPortrait.UITexture.height
          REF.TextureActorPortrait.UITexture.uvRect = rect
          REF.LabelName.UILabel.text = WU.GetString("ActorSkinName_" .. data.good.id)
          WU.SetActive(REF.SpriteSubActor, actorConfig.kind == PB.enum.ActorType.Sub)
          REF.SpriteDisplayIndex.UISprite.spriteName = "gacha_ActorSkin_" .. resSkin.displayIndex
        end
      end
    elseif data.good.type == PB.enum.ResourceType.ResUniqueWeapon then
      WU.SetActive(REF.SpriteActorType, false)
      WU.SetActive(REF.SpriteSubActor, false)
      WU.SetActive(REF.ArmName, true)
      WU.SetActive(REF.SpriteQualityBGArm, true)
      WU.SetActive(REF.TextureArmPortrait, true)
      local armConfig = PB.get("UniqueWeaponInfo", data.good.id)
      if armConfig == nil then
        error("UniqueWeaponInfo.xlsx has no id " .. data.good.id)
        return
      end
      local bGName
      if armConfig.quality == 4 then
        bGName = "gacha_impression_2"
      elseif armConfig.quality == 3 then
        bGName = "gacha_impression_1"
      end
      REF.SpriteQualityBGArm.UISprite.spriteName = bGName
      WU.ModifyWeaponPortrait(REF.TextureArmPortrait, data.good.id, PB.enum.WeaponPicSituationType.Shop)
      REF.ArmName.UILabel.text = WU.GetString("UniqueWeaponName_" .. data.good.id)
    else
      error("GachaScoreShop", "Unsupported resource type: " .. data.good.type)
    end
    REF.LabelCost.ResourcePrinter:SetResource(m_data.cost.type, m_data.cost.id, m_data.cost.count)
  end
end

function FindActorConfig(resSkin)
  local config, paletteIndex
  for i = 1, #resSkin.actorIds do
    local id = resSkin.actorIds[i]
    local resConfig = PB.get("ActorConfig", id)
    if resConfig and AU.IsActorOpen(resConfig.id, resConfig.openTime) then
      config = resConfig
      paletteIndex = resSkin.paletteIndexs[i]
      break
    end
  end
  return config, paletteIndex
end

function OnSlotClick()
  if m_data then
    if m_data.good.type == PB.enum.ResourceType.ResUniqueWeapon then
      this:SetData("GachaScoreShop/EnterType", 3)
    else
      this:SetData("GachaScoreShop/EnterType", 1)
    end
    this:SetData("GachaScoreShop/Goods", m_data)
    WU.AcquireWindowAsync("GachaScoreExchange")
  end
end

---
--- Created by Eric.
--- DateTime: 2021/10/19 16:48
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local CardDojo = import("Game.Dojo.CardDojo")

------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolHelpSelectCell
---@field ImgRareBg                     	Game.Native.Common.UISwitchImage
---@field AnimRoot                      	UnityEngine.RectTransform
---@field CardCell                      	UnityEngine.Animator
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CardNameLabel                 	UnityEngine.RectTransform
---@field Card                          	UnityEngine.RectTransform
---@field TxtCardName                   	UnityEngine.UI.Text
---@field ImgCardHead                   	Engine.UI.ImageAlterable
---@field SelectedBg                    	UnityEngine.RectTransform
local PatrolHelpSelectCell = Class("PatrolHelpSelectCell")
function PatrolHelpSelectCell:__init()
    self.btnActionGet = nil
    self.btnAction = nil

end

function PatrolHelpSelectCell:__delete()
    self.btnActionGet = nil
    self.btnAction = nil

    self.controller = nil
end

---SetBtnCallBackGet
---设置单击回调函数(获得助战)
function PatrolHelpSelectCell:SetBtnCallBackGet(cb)
    self.btnActionGet = cb
end

---SetCallBack
---设置单击回调函数
function PatrolHelpSelectCell:SetBtnCallBack(cb)
    self.btnAction = cb
end

function PatrolHelpSelectCell:Awake()
    SetButtonAction(self.Card, function ()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
    SetButtonAction(self.FontStyleButton, function()--领取
        if type(self.btnActionGet) == 'function' then
            self.btnActionGet()
        end
    end)
end

function PatrolHelpSelectCell:FreshBaseUI(data)
    local mazeRoleVo = CfUtils.GetCfVo(AutoIds.IdSetting361, "MazeAssistRoleVo", data.id)
    local cardSkinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(mazeRoleVo.cardSkin)
    local cardVo = CardConfMgr:GetInstance():GetCardBySkinRefId(mazeRoleVo.cardSkin)
    self.ImgRareBg.Status = cardVo.rare
    self.ImgCardHead:LoadSprite(cardSkinVo.cardHeadList)
    self.TxtCardName.text = cardSkinVo.name
    SetButtonAction(self.CardNameLabel, function ()
        local tmpData = {
            ["cardId"] = mazeRoleVo.cardId,
            ["cardSkin"] = mazeRoleVo.cardSkin,
            ["cardLevel"] = data.cardLevel,
            ["star"] = data.star,
            ["awakeningLevel"] = data.awakeningLevel,
        }
        --local cardData = CardUtils.GenerateCardVirtualData(tmpData)
        --local cardData = {
        --    ["cardExp"] = 0,
        --    ["id"] = 0,
        --    ["talentTree"] = "",
        --    ["equipmentCore"] =
        --    {
        --    },
        --    ["equipment4"] =
        --    {
        --    },
        --    ["cardSkin"] = mazeRoleVo.cardSkin,
        --    ["cardId"] = mazeRoleVo.assistId,
        --    ["equipment2"] =
        --    {
        --    },
        --    ["equipment3"] =
        --    {
        --    },
        --    ["cardLevel"] = data.cardLevel,
        --    ["equipment1"] =
        --    {
        --    },
        --    ["star"] = data.star,
        --    ["finalSkillLevel"] = 0,
        --}
        CardUtils.ShowCardPreview({previewType = Constants.UICultivateCardPreviewType.Virtual, cards = { tmpData }, isAssistant = true}, {
            { id = Constants.UITypeIds.PatrolMainDialog},
            { id = Constants.UITypeIds.PatrolChoiceEventDialog},
            { id = Constants.UITypeIds.PatrolHelpSelectDialog},
        })
    end)
end

function PatrolHelpSelectCell:FreshSelectStatus(isSelected)
    KTool.SetActive(self.SelectedBg, isSelected)
    KTool.SetActive(self.FontStyleButton, isSelected)
    if isSelected then
        self:PlaySelectAnim(isSelected)
    end
end

function PatrolHelpSelectCell:PlaySelectAnim(isSelected)
    self.CardCell:Play(isSelected and "Select" or "Cancel")
end

function PatrolHelpSelectCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return PatrolHelpSelectCell
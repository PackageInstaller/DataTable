-------------------------------------------------------------------------------
-- 社团 - 社团大厅 - 猫咪气泡节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-24 21:44:27
-------------------------------------------------------------------------------

local ChatConstants = import('Game.OverseaChat.ChatConstants')

local AnimName = {
    SHOW = 'OverseaClubHallBubbleNode_Go',
    HIDE = 'OverseaClubHallBubbleNode_Out',
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubHallBubbleNode.prefab > name: OverseaClubHallBubbleNode
---@class UIOverseaClubHallCatBubbleNode
---@field Env                           	UIOverseaClubHallCatBubbleNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    跟节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field MyselfNode                    	UnityEngine.RectTransform               	@ 2    自己节点
---@field MessageTxt                    	UnityEngine.RectTransform               	@ 3    信息文本
---@field EmojiNode                     	UnityEngine.RectTransform               	@ 4    表情节点
---@field EmojiImg                      	UnityEngine.RectTransform               	@ 5    表情图片
local UIOverseaClubHallCatBubbleNode = Class('UIOverseaClubHallCatBubbleNode')


function UIOverseaClubHallCatBubbleNode:__init()
    ---@type integer @ 显示时间戳
    self.showTimestamp_ = 0

    ---@type integer @ 隐藏时间戳
    self.hideTimestamp_ = 0
end


function UIOverseaClubHallCatBubbleNode:__delete()
    self.showTimestamp_ = nil
    self.hideTimestamp_ = nil
end


function UIOverseaClubHallCatBubbleNode:Awake()
end


function UIOverseaClubHallCatBubbleNode:Start()
end


function UIOverseaClubHallCatBubbleNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubHallCatBubbleNode:GetShowTimestamp()
    return self.showTimestamp_
end


---@return integer
function UIOverseaClubHallCatBubbleNode:GetHideTimestamp()
    return self.hideTimestamp_
end


-------------------------------------------------
-- public

---@param chatData table
function UIOverseaClubHallCatBubbleNode:DoShow(chatData)
    self:UpdateMessageInfo_(chatData)
    self.hideTimestamp_ = 0
    self.showTimestamp_ = os.time() + CfUtils.GetAnimationTime(self.AnimNode, AnimName.SHOW)
    CfUtils.PlayAnimation(self.AnimNode, AnimName.SHOW)
end


function UIOverseaClubHallCatBubbleNode:DoHide()
    self.hideTimestamp_ = os.time() + CfUtils.GetAnimationTime(self.AnimNode, AnimName.HIDE)
    CfUtils.PlayAnimation(self.AnimNode, AnimName.HIDE)
end


-------------------------------------------------
-- private

function UIOverseaClubHallCatBubbleNode:UpdateMessageInfo_(chatData)
    local chatPlayerId = checkInt(chatData.playerId)
    local isMySelfChat = GameUtils.IsMySelfPlayerId(chatPlayerId)
    CfUtils.SetActive(self.MyselfNode, isMySelfChat)

    local msgType = checkInt(chatData.msgType)
    local isEmoji = msgType == ChatConstants.ChatMsgType.EMOJI
    CfUtils.SetActive(self.EmojiNode, isEmoji)

    local nameColor = isMySelfChat and '#DC68DA' or '#7A7A83'
    local nameText  = string.fmt('<color=%1>%2</color>：', nameColor, tostring(chatData.name))
    local chatText  = tostring(chatData.message)
    if msgType == ChatConstants.ChatMsgType.EMOJI then
        local _, _, _, goodsId = string.find(chatText, "^#(%[)(%d+)(%])#$")
        if goodsId then
            ---@type GoodsEmojiVo
            local vo = CfUtils.GetCfVo(AutoIds.IdSetting2768, "GoodsEmojiVo", goodsId)
            if vo then
                CfUtils.FillImage(self.EmojiImg, vo.photoPath)
            end
        end
        CfUtils.FillText(self.MessageTxt, nameText)
    else
        CfUtils.FillText(self.MessageTxt, nameText .. chatText)
    end
end


return UIOverseaClubHallCatBubbleNode

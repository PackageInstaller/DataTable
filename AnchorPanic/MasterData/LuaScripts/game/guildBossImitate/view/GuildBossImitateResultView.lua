-- @FileName:   GuildBossImitateResultView.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-13 17:25:07
-- @Copyright:   (LY) 2023 雷焰网络

module('game.guildBossImitate.view.GuildBossImitateResultView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildBossImitate/GuildBossImitateResultView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mTextTitle_1 = self:getChildGO("mTextTitle_1"):GetComponent(ty.Text)
    self.mTextDamage = self:getChildGO("mTextDamage"):GetComponent(ty.Text)
    self.mText_Damage = self:getChildGO("mText_Damage"):GetComponent(ty.Text)
    self.mTextMaxDamage = self:getChildGO("mTextMaxDamage"):GetComponent(ty.Text)
    self.mText_MaxDamage = self:getChildGO("mText_MaxDamage"):GetComponent(ty.Text)
    self.mNewRecord = self:getChildGO("mNewRecord")

    self.mTextRank = self:getChildGO("mTextRank"):GetComponent(ty.Text)
    self.mText_Rank = self:getChildGO("mText_Rank"):GetComponent(ty.Text)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextTitle_1.text = _TT(108015)
    self.mTextDamage.text = _TT(108016)
    self.mTextMaxDamage.text = _TT(108017)
    self.mTextRank.text = _TT(108018)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

--激活
function active(self, args)
    super.active(self, args)

    self.mText_Damage.text = args.damage
    self.mText_MaxDamage.text = args.cache_damage
    self.mTextRank.gameObject:SetActive(args.rank > 0)
    self.mText_Rank.text = _TT(194, args.rank)
    self.mNewRecord:SetActive(args.new_record)
end

--非激活
function deActive(self)
    super.deActive(self)

    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {isWin = false})
end

return _M

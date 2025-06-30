--[[
-----------------------------------------------------
   @CreateTime:2025/2/14 15:18:45
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:dna开箱子品质动画界面
]]

module("game.dna.view.DnaOpenBoxEfxPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('dna/DnaOpenBoxEfxPanel.prefab')
panelType = 2     -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1  -- 自动销毁时间-1默认 0即时销毁 999不销毁
-- isShowBlackBg = 1 --是否显示全屏纯黑防穿帮底图
isShowMoneyBar = 0 -- 是否显示货币栏 1开启（仅2弹窗有效）
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
escapeClose = 0 -- 是否能通过esc关闭窗口

function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
end

function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
end

function initArgs(self, args)
    self.eggMaxQuality = args and args.eggMaxQuality or nil
    self.callBack = args and args.callBack or nil
end

function active(self, args)
    super.active(self, args)
    self:initArgs(args)

    for i = 1, 3 do
        self:getChildGO("Effect0" .. i):SetActive(false)
    end
    self:getChildGO("Effect0" .. self.eggMaxQuality):SetActive(true)
    self.timeSn = LoopManager:setTimeout(3, self, self.closeView)
    AudioManager:playSoundEffect(UrlManager:getDnaOtherSoundPath("ui_dna_basic_openbubble"))
end

function deActive(self)
    super.deActive(self)
    self:initArgs()
    self:destroyTimeSn()
end

function destroyTimeSn(self)
    if self.timeSn then
        LoopManager:clearTimeout(self.timeSn)
        self.timeSn = nil
    end
end

function closeView(self)
    local cb = self.callBack
    self:close()
    if cb then
        cb()
    end
end

return _M

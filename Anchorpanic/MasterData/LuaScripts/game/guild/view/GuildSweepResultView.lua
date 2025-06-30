
module('guild.GuildSweepResultView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSweepResultView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mTextBossName = self:getChildGO("mTextBossName"):GetComponent(ty.Text)
    --self.mTextBossStage = self:getChildGO("mTextBossStage"):GetComponent(ty.Text)

    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mText_Hp = self:getChildGO("mText_Hp"):GetComponent(ty.Text)
    self.mText_Damage = self:getChildGO("mText_Damage"):GetComponent(ty.Text)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

--激活
function active(self, args)
    super.active(self, args)

    self.mShowTime = os.time()
    
    if guild.GuildManager:getGuildSweepState() == 0 then
        if not args.isAlive then
            gs.Message.Show(_TT(94592))
        end
    else
        gs.Message.Show(_TT(94503))
    end

    self.mTextBossName.text =    guild.GuildManager:getSweepBossName()
    self.mText_Damage.text = args.damage
    self.mText_Hp.text = args.now_hp .. "/" .. args.max_hp
    self.mImgProgress.fillAmount = args.now_hp / args.max_hp
end

--非激活
function deActive(self)
    super.deActive(self)

    --guild.GuildManager:clearGuildBossFightDamage()
    self:sendFightOver()
end

-- 关闭界面发送通知
function sendFightOver(self)
    if not self.isLink then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {isWin = false})
    end
end

-- 玩家点击关闭
function onClickClose(self)
    if os.time() - self.mShowTime > 2 then
        self:close()
    end
end

return _M


module("tips.BossSkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/BossSkillTips.prefab")

isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
--panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(0, 0)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
   self.mSkillItems = {}
end

--初始化UI
function configUI(self)
    super.configUI(self)

    self.mBossHead = self:getChildGO("mImgHead") :GetComponent(ty.AutoRefImage)
    self.mBossJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)

    self.mBossName = self:getChildGO("mTextName"):GetComponent(ty.Text)

    self.mSkillContent = self:getChildTrans("mSkillContent")

    self.mSkillItem = self:getChildGO("mSkillItem")

    self.mTextSkilllTitle = self:getChildGO("mTextSkilllTitle"):GetComponent(ty.Text)
end


function active(self, args)
    super.active(self, args)

    self:updateBossSkill()
end

function updateBossSkill(self)
    self.mTextSkilllTitle.text = _TT(43116)
    local dupData = fight.SceneManager:getCusDupData()
    if dupData.bossId == 0 then
        return
    end

    local vo = monster.MonsterManager:getMonsterVo(dupData.bossId)
    local bossVo = monster.MonsterManager:getMonsterVo01(vo.tid)
    self.mBossName.text = bossVo.name
    self.mBossHead:SetImg(UrlManager:getHeroBodyUrlByImgName(bossVo.boss_head) ,true)
    self.mBossJob:SetImg(UrlManager:getMonsterJobSmallIconUrl(bossVo.professionType),false)

    for i=1,#dupData.bossCha do
        local item = SimpleInsItem:create(self.mSkillItem, self.mSkillContent, "BossSkillTipsbossSkillTips")
        item:getChildGO("mTxtSkillName"):GetComponent(ty.Text).text = _TT(dupData.bossCha[i][1])
        item:getChildGO("mTxtSkillDes"):GetComponent(ty.Text).text = _TT(dupData.bossCha[i][2])
        table.insert(self.mSkillItems,item)
    end
end


function deActive(self)
    super.deActive(self)

    for i = 1,#self.mSkillItems do
        self.mSkillItems[i]:poolRecover()
    end
    self.mSkillItems = {}
end

function initViewText(self)
end


-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M
module("disaster.DisasterBossPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("disaster/DisasterBossPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(104012))
    self:setSize(1120, 520)
end

function initData(self)
    self.mAwardList = {}
end

function configUI(self)
    super.configUI(self)

    self.mIconBoss = self:getChildGO("mIconBoss"):GetComponent(ty.AutoRefImage)
    self.mTxtBossName = self:getChildGO("mTxtBossName"):GetComponent(ty.Text)
    self.mTxtBossLv = self:getChildGO("mTxtBossLv"):GetComponent(ty.Text)
    self.mTxtHp = self:getChildGO("mTxtHp"):GetComponent(ty.Text)
    self.mImgSliderBg = self:getChildGO("mImgSliderBg"):GetComponent(ty.RectTransform)
    self.mImgSlider = self:getChildGO("mImgSlider"):GetComponent(ty.RectTransform)
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildTrans("mAwardContent")

    self.mTxtInf = self:getChildGO("mTxtInf"):GetComponent(ty.Text)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --self.mTxtAward.text = _TT(104011)
    self.mTxtInf.text = _TT(104014)
end

function active(self, args)
    super.active(self, args)

    self.curDif = args.curDif
    self.dupVo = args.dupVo
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    self:clearPropsList()
end

function showPanel(self)
    local tidVo = monster.MonsterManager:getMonsterVo(self.dupVo.bossId)
    self.mTxtBossLv.text = "Lv.".. tidVo.lvl

    self.monConfig = monster.MonsterManager:getMonsterVo01(tidVo.tid)
    self.mTxtBossName.text = self.monConfig.name

    local strPath = string.format("arts/ui/bg/guild/%s_01.png", self.dupVo.bossImg)
    self.mIconBoss:SetImg(strPath, false)

    local remHp,allHp = disaster.DisasterManager:getBossInfo(self.curDif)
    gs.TransQuick:SizeDelta01(self.mImgSlider, remHp/allHp* self.mImgSliderBg.sizeDelta.x)
    self.mTxtHp.text = remHp.."/"..allHp
    self:clearPropsList()
    local awardList = AwardPackManager:getAwardListById(self.dupVo.firstAwardId)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, { vo.tid, vo.num }, 0.75, false)
        table.insert(self.mAwardList, propsGrid)
    end
    self.mTxtInf.gameObject:SetActive(self.curDif == disaster.DisasterManager:getDisasterDupMaxDif())

    if(self.curDif == disaster.DisasterManager:getDisasterDupMaxDif()) then
        self.mTxtAward.text = _TT(104013)
        
    else
        self.mTxtAward.text = _TT(104011)
    end
    self.mTxtHp.gameObject:SetActive(self.curDif ~= disaster.DisasterManager:getDisasterDupMaxDif())
    self.mImgSliderBg.gameObject:SetActive(self.curDif ~= disaster.DisasterManager:getDisasterDupMaxDif())
end

function clearPropsList(self)
    for i = 1, #self.mAwardList do
        self.mAwardList[i]:poolRecover()
    end
    self.mAwardList = {}
end

return _M
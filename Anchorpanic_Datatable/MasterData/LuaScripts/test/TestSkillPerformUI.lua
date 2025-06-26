module('TestSkillPerformUI', Class.impl('lib.component.BaseContainer'))
UIRes = UrlManager:getUIPrefabPath('test/TestSkillPerformUI.prefab')

function _playerSkill(self, skillID, casterID, targetID)
    local tr = STravelFactory:travel(skillID, casterID, targetID)
    tr:start()
    local th = fight.SceneItemManager:getLivething(casterID)
    if th then
        th.m_ani:PlayFade("atk01")
        -- th:playAttack({skillCd=0})
        -- BuffHandler:addBuff(casterID, math.random(1,5))
    end
end
-- 初始化
function configUI(self)
    local function _isCompele()
        print("_isCompele")
    end
    AssetLoader.PreLoadListAsyn({"14_RFX_Magic_Buff1.prefab","Flame Enchant.prefab","Qk_fire_arrow_01_projectile_01.prefab",
    "Qk_ice_arrow_01_hit_01.prefab","Qk_ice_arrow_01_projectil_01.prefab","50_RFX_Tonado_Electro1.prefab","Boom.prefab",
    "Burning Ground.prefab","a1_eft_bingdong_01.prefab"},_isCompele)

    self.m_isLoadFormation = false
    local function _createCall()
        if self.m_isLoadFormation==true then return end
        self.m_isLoadFormation = true
        self:createFormation()
        self:getChildGO('CreateBtn'):SetActive(false)
    end
    self:addOnClick(self:getChildGO('CreateBtn'), _createCall)

    local function _btn1Call()
        self:_playerSkill(1,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn1'), _btn1Call)

    local function _btn2Call()
        self:_playerSkill(2,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn2'), _btn2Call)

    local function _btn3Call()
        self:_playerSkill(3,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn3'), _btn3Call)

    local function _btn4Call()
        self:_playerSkill(4,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn4'), _btn4Call)

    local function _btn5Call()
        self:_playerSkill(5,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn5'), _btn5Call)

    local function _btn6Call()
        self:_playerSkill(4,math.random(1,5),math.random(6,10))
    end
    self:addOnClick(self:getChildGO('Btn6'), _btn6Call)
end

function createFormation()
    local COL_COUNT = 122
    local ATT_POS = {
        fight.Tile(50,15),
        fight.Tile(50,25),
        fight.Tile(30,10),
        fight.Tile(30,20),
        fight.Tile(30,30)
    };
    local DEF_POS = {
        fight.Tile(COL_COUNT-50,15),
        fight.Tile(COL_COUNT-50,25),
        fight.Tile(COL_COUNT-30,10),
        fight.Tile(COL_COUNT-30,20),
        fight.Tile(COL_COUNT-30,30)
    };

    local sCamera = gs.CameraMgr:GetSceneCamera()
    gs.TransQuick:Pos(sCamera.transform, -4.5,5,7)
    gs.TransQuick:SetRotation(sCamera.transform, 22,-170,0)
    -- 添加测试单位
    fight.SceneManager:reset();
    fight.SceneManager.gNowId = 1;
	for _,v in ipairs(ATT_POS) do
		local vo = fight.LivethingVo.new(fight.SceneManager.gNowId,true);
		vo:initPosition(fight.SceneUtil.tileToPosition(v));
		vo:setAtts(fight.SceneManager:testAtts())
		vo.isAtt = true;
		fight.SceneManager:addThing(vo);
		fight.SceneManager.gNowId = fight.SceneManager.gNowId + 1;
	end

	for _,v in ipairs(DEF_POS) do
		local vo = fight.LivethingVo.new(fight.SceneManager.gNowId,false);
		vo:initPosition(fight.SceneUtil.tileToPosition(v));
		vo:setAtts(fight.SceneManager:testAtts())
		vo.isAtt = false;
		fight.SceneManager:addThing(vo);
		fight.SceneManager.gNowId = fight.SceneManager.gNowId + 1;
    end
    local _dic = fight.SceneManager.gThingDic;
	for _, vo in pairs(_dic) do
		fight.SceneItemManager:addLivething(vo);
    end
end

-- 设置父容器
function getParentTrans(self)
    return GameView.mainUI
end

-- 激活
function active(self)
end
-- 非激活
function deActive(self)
end

return _M

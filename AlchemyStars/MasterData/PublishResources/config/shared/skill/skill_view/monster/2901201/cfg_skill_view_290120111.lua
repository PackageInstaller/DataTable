LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2901201/cfg_skill_view_290120111.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁÁ  B  A  Á ŤB ë@AA A Á B  A  Ë C ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙y       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,setPieceViewShow=1; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; x PlayEffectAGridPos,effectID=3178,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; Wait,waitTime=1000; DestroyAbyssEffect;  DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29012019,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         0                                                                                                                                                      key   0   config+   0      _ENV
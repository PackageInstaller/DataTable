LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905701/cfg_skill_view_290570103.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@��AA �A � B  AB  � �� C �B� +A�K��� ��  AB  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               �%       PlayCasterAnimation,animName = skill013; PlayAudio,audioID = 7055,audioType=1; PlayCasterMaterialAnim,animName=eff_2905701_skill01_in_mat; PlayCasterBindEffect,effectID=290570114; Wait,waitTime=1200; PlayRoleTeleport,type=3,onlySelf=0; PlayRoleTeleport,type=5,onlySelf=0; Wait,waitTime=300; �      ��      PlayAudio,audioID = 7058,audioType=1; PlayCasterBindEffect,effectID=290570115; Wait,waitTime=1500; PlayRoleTeleport,type=6,onlySelf=0; PlayCasterAnimation,animName = skill03; PlayCasterMaterialAnim,animName=effanim_2905701_skill03_main; Wait,waitTime=2400; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;�      �.       DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; X      �e       PlayTeleportResultTarget,type=3,stageIndex=2; PlayTeleportResultTarget,type=5,stageIndex=2; PlayTeleportResultTarget,type=6,stageIndex=2; PlayTeleportResultTarget,type=9,stageIndex=2;DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=0; Wait,waitTime=300; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        <                                                                                                                                                                                          key	   <   config7   <      _ENV
LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1502201/cfg_skill_view_300220.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  � �� � �B� +A�K��� ��  AB  ��  � � AC +C� kA����A B A ��  ��   K� �� kC� �A���� A� � ��  C A� �� � �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;��       PlayCasterAnimation,animName = AtkUlt; Play1502201FangDaJing, effectID=150220106, gridEffect1ID=150220107, gridEffect2ID=150220108, effectInAnim=eff_1502201_atkult_main_fangdajing_in, effectLoopAnim=eff_1502201_atkult_main_fangdajing_loop, effectOutAnim=eff_1502201_atkult_main_fangdajing_out, effectOutAnim2=eff_1502201_atkult_main_fangdajing_out2, effectMoveWaitTime=3000, effectMoveWaitTimeLen=330, gridEffectWaitTime1=450, gridEffectWaitTime2=780, effectWaitInTime=1000, effectOutWaitTime=1470, effectOutWaitTime2=1470, effectOutBeginWaitTime=1200; PlayEntityLegacyAnimation,animNames=eff_1502201_atkult_gezi_out,casterEffectID=150220110; � Wait,waitTime=400; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID = 150220104,audioType=1; �      ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=150220110,label=playRangeEffect,bindCaster=1; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;�~      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      0 PlayDeleteCasterEffect,effectIDList=150220110;        R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV
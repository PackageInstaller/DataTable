LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602211/cfg_skill_view_300221.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �� � AC +C� kA����A B A ��  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               }PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1602211,waitTime = 2000;�e       PlayAudio,audioID = 160221104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =160221107; Wait,waitTime=250; PlayCameraEffect,effectID =160221104; Wait,waitTime=550; PlayEffectAtPickUpIndexGrid,effectID=160221105,pickUpIndex=1; PlaySummonTrap,trapID=2803501; Wait,waitTime=4800; PlayCasterBindEffect,effectID =160221108; (
      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160221106,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4002211,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; �      � DataSelectScopeGridRangePickUp,pickUpIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV
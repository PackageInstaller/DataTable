LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909301/cfg_skill_view_29093013.lua         Q   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  ��  � � AC +C� kA����A B A� ��  ��  � K� �� kC� �A���� A� �� ��  �  A �� �C �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; ,      �J       PlayCasterAnimation,animName=Skill_01; PlayCasterMaterialAnim,animName=effanim_2909301_skil01; PlayAudio,audioID = 6231,audioType=1; Wait,waitTime=430; PlayCasterBindEffect,effectID=29093013; PlayCasterBindEffect,effectID=29093014; PlayTeleportAsMoving,time=500; PlayRoleTeleport,type=9; PlayCasterBindEffect,effectID=29093015; >      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �	      � PlayTeamHUDVisible,visible=0; Wait,waitTime=300; PlayPushBoard, dirX=0, dirY=-1; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; PlayRefreshAllHPPos,forceRefreshHPPercent=1; �      ! PlaySummonTrap,trapID=2909301;       � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=2909302,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         Q                                                                                                                                                                                                                                    	   
   
   
   
   
      key   Q   configL   Q      _ENV
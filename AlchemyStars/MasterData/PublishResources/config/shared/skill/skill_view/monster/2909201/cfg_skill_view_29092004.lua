LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909201/cfg_skill_view_29092004.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = Atk01_1; PlayCasterBindEffect,effectID =290920113; PlayAudio,audioID = 290920102,audioType=1; Wait,waitTime=667; PlayTeleportAsMoving,speed=33; PlayRoleTeleport,type=9;       �:      DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920114,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29092006,label=doAgain; PlayTargetAddBuff,buffID=20021; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;        %                                                                                                                     key   %   config    %      _ENV
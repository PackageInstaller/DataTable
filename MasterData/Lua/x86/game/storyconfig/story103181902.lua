return {
	Play318192001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318192001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318192002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K04f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K04f")
				var_4_0.name = "K04f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K04f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K04f

				arg_1_1.bgs_.K04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K04f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword04", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318192001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)

				if (52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318192002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318192002
		arg_9_1.duration_ = 3.97

		local var_9_0 = {
			zh = 3.233,
			ja = 3.966
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318192003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10053ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10053ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10053ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10053ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10053ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect10053ui_story == nil then
				arg_9_1.var_.characterEffect10053ui_story = var_12_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_4 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 and not isNil(var_12_3) then
				if arg_9_1.var_.characterEffect10053ui_story and not isNil(var_12_3) then
					arg_9_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect10053ui_story then
				arg_9_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_6 = arg_9_1.actors_["10053ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10053ui_story = var_12_6.localPosition
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_9_1.time_ - 0) / var_12_7)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0, -1.12, -5.99)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			local var_12_8 = 0
			local var_12_9 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(318192002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 13 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 13)

				if (13 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 13)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192002", "story_v_out_318192.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_318192", "318192002", "story_v_out_318192.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_318192", "318192002", "story_v_out_318192.awb")

						arg_9_1:RecordAudio("318192002", var_12_15)
						arg_9_1:RecordAudio("318192002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318192", "318192002", "story_v_out_318192.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318192", "318192002", "story_v_out_318192.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play318192003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318192003
		arg_13_1.duration_ = 6.23

		local var_13_0 = {
			zh = 5.3,
			ja = 6.233
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318192004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1058ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1058ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1058ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1058ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1058ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1058ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1058ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1058ui_story == nil then
				arg_13_1.var_.characterEffect1058ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1058ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1058ui_story then
				arg_13_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = arg_13_1.actors_["10053ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10053ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10053ui_story, Vector3.New(-0.7, -1.12, -5.99), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-0.7, -1.12, -5.99)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["10053ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10053ui_story == nil then
				arg_13_1.var_.characterEffect10053ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect10053ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10053ui_story then
				arg_13_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(318192003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 29 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 29)

				if (29 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 29)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192003", "story_v_out_318192.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_318192", "318192003", "story_v_out_318192.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_318192", "318192003", "story_v_out_318192.awb")

						arg_13_1:RecordAudio("318192003", var_16_19)
						arg_13_1:RecordAudio("318192003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318192", "318192003", "story_v_out_318192.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318192", "318192003", "story_v_out_318192.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play318192004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318192004
		arg_17_1.duration_ = 10.97

		local var_17_0 = {
			zh = 6.133,
			ja = 10.966
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318192005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) and arg_17_1.var_.characterEffect10053ui_story == nil then
				arg_17_1.var_.characterEffect10053ui_story = arg_17_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) then
				if arg_17_1.var_.characterEffect10053ui_story and not isNil(arg_17_1.actors_["10053ui_story"]) then
					arg_17_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10053ui_story"]) and arg_17_1.var_.characterEffect10053ui_story then
				arg_17_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_20_2 = arg_17_1.actors_["1058ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1058ui_story == nil then
				arg_17_1.var_.characterEffect1058ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect1058ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1058ui_story then
				arg_17_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.75

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(318192004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 30 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 30)

				if (30 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 30)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192004", "story_v_out_318192.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_318192", "318192004", "story_v_out_318192.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_318192", "318192004", "story_v_out_318192.awb")

						arg_17_1:RecordAudio("318192004", var_20_11)
						arg_17_1:RecordAudio("318192004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318192", "318192004", "story_v_out_318192.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318192", "318192004", "story_v_out_318192.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play318192005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318192005
		arg_21_1.duration_ = 6.7

		local var_21_0 = {
			zh = 5.633,
			ja = 6.7
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318192006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_0 = 0
			local var_24_1 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(318192005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 20 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 20)

				if (20 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 20)) > 0 and var_24_1 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192005", "story_v_out_318192.awb") ~= 0 then
					local var_24_6 = manager.audio:GetVoiceLength("story_v_out_318192", "318192005", "story_v_out_318192.awb") / 1000

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end

					if var_24_2.prefab_name ~= "" and arg_21_1.actors_[var_24_2.prefab_name] ~= nil then
						local var_24_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_2.prefab_name].transform, "story_v_out_318192", "318192005", "story_v_out_318192.awb")

						arg_21_1:RecordAudio("318192005", var_24_7)
						arg_21_1:RecordAudio("318192005", var_24_7)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318192", "318192005", "story_v_out_318192.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318192", "318192005", "story_v_out_318192.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318192006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318192006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318192007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = arg_25_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) then
				if arg_25_1.var_.characterEffect10053ui_story and not isNil(arg_25_1.actors_["10053ui_story"]) then
					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10053ui_story"]) and arg_25_1.var_.characterEffect10053ui_story then
				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(318192006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 57 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 57)

				if (57 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 57)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318192007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318192007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			zh = 3,
			ja = 3.9
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play318192008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) and arg_29_1.var_.characterEffect10053ui_story == nil then
				arg_29_1.var_.characterEffect10053ui_story = arg_29_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) then
				if arg_29_1.var_.characterEffect10053ui_story and not isNil(arg_29_1.actors_["10053ui_story"]) then
					arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10053ui_story"]) and arg_29_1.var_.characterEffect10053ui_story then
				arg_29_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(318192007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 3 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 3)

				if (3 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 3)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192007", "story_v_out_318192.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_318192", "318192007", "story_v_out_318192.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_318192", "318192007", "story_v_out_318192.awb")

						arg_29_1:RecordAudio("318192007", var_32_9)
						arg_29_1:RecordAudio("318192007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318192", "318192007", "story_v_out_318192.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318192", "318192007", "story_v_out_318192.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318192008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318192008
		arg_33_1.duration_ = 6.5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318192009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.K04f_blur == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K04f_blur")
				var_36_0.name = "K04f_blur"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.K04f_blur = var_36_0
			end

			if 1.5 < arg_33_1.time_ and arg_33_1.time_ <= 1.5 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.K04f_blur

				arg_33_1.bgs_.K04f_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "K04f_blur" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = arg_33_1.actors_["10053ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect10053ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10053ui_story then
				arg_33_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_36_6 = arg_33_1.actors_["10053ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10053ui_story = var_36_6.localPosition
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_6.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_7)
				var_36_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_6.position).x, (manager.ui.mainCamera.transform.position - var_36_6.position).y, (manager.ui.mainCamera.transform.position - var_36_6.position).z)
				var_36_6.localEulerAngles.z = 0
				var_36_6.localEulerAngles.x = 0
				var_36_6.localEulerAngles = var_36_6.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_6.localPosition = Vector3.New(0, 100, 0)
				var_36_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_6.position).x, (manager.ui.mainCamera.transform.position - var_36_6.position).y, (manager.ui.mainCamera.transform.position - var_36_6.position).z)
				var_36_6.localEulerAngles.z = 0
				var_36_6.localEulerAngles.x = 0
				var_36_6.localEulerAngles = var_36_6.localEulerAngles
			end

			local var_36_8 = arg_33_1.actors_["1058ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1058ui_story = var_36_8.localPosition
			end

			local var_36_9 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_9)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, 100, 0)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			local var_36_10 = manager.ui.mainCamera.transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_10.localPosition
			end

			local var_36_11 = 0.6

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 then
				local var_36_12, var_36_13 = math.modf((arg_33_1.time_ - 0) / 0.066)

				var_36_10.localPosition = Vector3.New(var_36_13 * 0.13, var_36_13 * 0.13, var_36_13 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 then
				var_36_10.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_14 = manager.ui.mainCamera.transform

			if 0.9 < arg_33_1.time_ and arg_33_1.time_ <= 0.9 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_14.localPosition
			end

			local var_36_15 = 0.6

			if 0.9 <= arg_33_1.time_ and arg_33_1.time_ < 0.9 + var_36_15 then
				local var_36_16, var_36_17 = math.modf((arg_33_1.time_ - 0.9) / 0.066)

				var_36_14.localPosition = Vector3.New(var_36_17 * 0.13, var_36_17 * 0.13, var_36_17 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0.9 + var_36_15 and arg_33_1.time_ < 0.9 + var_36_15 + arg_36_0 then
				var_36_14.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_18 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			if arg_33_1.time_ >= var_36_18 + 3.699999999999 and arg_33_1.time_ < var_36_18 + 3.699999999999 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_19 = "K04f_blur"

			if arg_33_1.bgs_.K04f_blur == nil then
				local var_36_20 = Object.Instantiate(arg_33_1.blurPaintGo_)

				var_36_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_19)
				var_36_20.name = var_36_19
				var_36_20.transform.parent = arg_33_1.stage_.transform
				var_36_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_19] = var_36_20
			end

			local var_36_21 = 1.5
			local var_36_22 = arg_33_1.bgs_[var_36_19]

			if 1.5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				var_36_22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_23 = var_36_22:GetComponent("SpriteRenderer")

				if var_36_23 and var_36_23.sprite then
					local var_36_24 = 2 * (var_36_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_22.transform.localScale = Vector3.New(var_36_24 / var_36_23.sprite.bounds.size.y < var_36_24 * manager.ui.mainCameraCom_.aspect / var_36_23.sprite.bounds.size.x and var_36_24 * manager.ui.mainCameraCom_.aspect / var_36_23.sprite.bounds.size.x or var_36_24 / var_36_23.sprite.bounds.size.y, var_36_24 / var_36_23.sprite.bounds.size.y < var_36_24 * manager.ui.mainCameraCom_.aspect / var_36_23.sprite.bounds.size.x and var_36_24 * manager.ui.mainCameraCom_.aspect / var_36_23.sprite.bounds.size.x or var_36_24 / var_36_23.sprite.bounds.size.y, 0)
				end
			end

			local var_36_25 = 0.6

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_25 then
				local var_36_26 = Color.New(1, 1, 1)

				var_36_26.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_21) / var_36_25)

				var_36_22:GetComponent("SpriteRenderer").material:SetColor("_Color", var_36_26)
			end

			local var_36_27 = "K04f_blur"

			if arg_33_1.bgs_.K04f_blur == nil then
				local var_36_28 = Object.Instantiate(arg_33_1.blurPaintGo_)

				var_36_28:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_27)
				var_36_28.name = var_36_27
				var_36_28.transform.parent = arg_33_1.stage_.transform
				var_36_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_27] = var_36_28
			end

			local var_36_29 = 2.1
			local var_36_30 = arg_33_1.bgs_[var_36_27]

			if 2.1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_29 + arg_36_0 then
				var_36_30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_31 = var_36_30:GetComponent("SpriteRenderer")

				if var_36_31 and var_36_31.sprite then
					local var_36_32 = 2 * (var_36_30.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_30.transform.localScale = Vector3.New(var_36_32 / var_36_31.sprite.bounds.size.y < var_36_32 * manager.ui.mainCameraCom_.aspect / var_36_31.sprite.bounds.size.x and var_36_32 * manager.ui.mainCameraCom_.aspect / var_36_31.sprite.bounds.size.x or var_36_32 / var_36_31.sprite.bounds.size.y, var_36_32 / var_36_31.sprite.bounds.size.y < var_36_32 * manager.ui.mainCameraCom_.aspect / var_36_31.sprite.bounds.size.x and var_36_32 * manager.ui.mainCameraCom_.aspect / var_36_31.sprite.bounds.size.x or var_36_32 / var_36_31.sprite.bounds.size.y, 0)
				end
			end

			local var_36_33 = 0.8

			if var_36_29 <= arg_33_1.time_ and arg_33_1.time_ < var_36_29 + var_36_33 then
				local var_36_34 = Color.New(1, 1, 1)

				var_36_34.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_29) / var_36_33)

				var_36_30:GetComponent("SpriteRenderer").material:SetColor("_Color", var_36_34)
			end

			local var_36_35 = "K04f_blur"

			if arg_33_1.bgs_.K04f_blur == nil then
				local var_36_36 = Object.Instantiate(arg_33_1.blurPaintGo_)

				var_36_36:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_35)
				var_36_36.name = var_36_35
				var_36_36.transform.parent = arg_33_1.stage_.transform
				var_36_36.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_35] = var_36_36
			end

			local var_36_37 = 2.9
			local var_36_38 = arg_33_1.bgs_[var_36_35]

			if 2.9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_37 + arg_36_0 then
				var_36_38.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_38.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_39 = var_36_38:GetComponent("SpriteRenderer")

				if var_36_39 and var_36_39.sprite then
					local var_36_40 = 2 * (var_36_38.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_38.transform.localScale = Vector3.New(var_36_40 / var_36_39.sprite.bounds.size.y < var_36_40 * manager.ui.mainCameraCom_.aspect / var_36_39.sprite.bounds.size.x and var_36_40 * manager.ui.mainCameraCom_.aspect / var_36_39.sprite.bounds.size.x or var_36_40 / var_36_39.sprite.bounds.size.y, var_36_40 / var_36_39.sprite.bounds.size.y < var_36_40 * manager.ui.mainCameraCom_.aspect / var_36_39.sprite.bounds.size.x and var_36_40 * manager.ui.mainCameraCom_.aspect / var_36_39.sprite.bounds.size.x or var_36_40 / var_36_39.sprite.bounds.size.y, 0)
				end
			end

			local var_36_41 = 0.8

			if var_36_37 <= arg_33_1.time_ and arg_33_1.time_ < var_36_37 + var_36_41 then
				local var_36_42 = Color.New(1, 1, 1)

				var_36_42.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_37) / var_36_41)

				var_36_38:GetComponent("SpriteRenderer").material:SetColor("_Color", var_36_42)
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_43 = 1.5
			local var_36_44 = 1.225

			if 1.5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_43 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_45 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_45:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_46 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(318192008).content)

				arg_33_1.text_.text = var_36_46

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_48 = 49 <= 0 and var_36_44 or var_36_44 * (utf8.len(var_36_46) / 49)

				if (49 <= 0 and var_36_44 or var_36_44 * (utf8.len(var_36_46) / 49)) > 0 and var_36_44 < var_36_48 then
					arg_33_1.talkMaxDuration = var_36_48
					var_36_43 = var_36_43 + 0.3

					if var_36_48 + var_36_43 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_48 + var_36_43
					end
				end

				arg_33_1.text_.text = var_36_46
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_49 = var_36_43 + 0.3
			local var_36_50 = math.max(var_36_44, arg_33_1.talkMaxDuration)

			if var_36_43 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_49 + var_36_50 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_49) / var_36_50

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_49 + var_36_50 and arg_33_1.time_ < var_36_49 + var_36_50 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play318192009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 318192009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play318192010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.35

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(318192009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 14)

				if (14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 14)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play318192010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 318192010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play318192011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(318192010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 16 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 16)

				if (16 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 16)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play318192011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 318192011
		arg_47_1.duration_ = 2.63

		local var_47_0 = {
			zh = 2.1,
			ja = 2.633
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play318192012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1058ui_story"]) and arg_47_1.var_.characterEffect1058ui_story == nil then
				arg_47_1.var_.characterEffect1058ui_story = arg_47_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1058ui_story"]) then
				if arg_47_1.var_.characterEffect1058ui_story and not isNil(arg_47_1.actors_["1058ui_story"]) then
					arg_47_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1058ui_story"]) and arg_47_1.var_.characterEffect1058ui_story then
				arg_47_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_50_2 = 0
			local var_50_3 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_4 = arg_47_1:GetWordFromCfg(318192011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 9 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 9)

				if (9 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 9)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192011", "story_v_out_318192.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_318192", "318192011", "story_v_out_318192.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_318192", "318192011", "story_v_out_318192.awb")

						arg_47_1:RecordAudio("318192011", var_50_9)
						arg_47_1:RecordAudio("318192011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_318192", "318192011", "story_v_out_318192.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_318192", "318192011", "story_v_out_318192.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play318192012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 318192012
		arg_51_1.duration_ = 3

		local var_51_0 = {
			zh = 3,
			ja = 2.366
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play318192013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10053ui_story"]) and arg_51_1.var_.characterEffect10053ui_story == nil then
				arg_51_1.var_.characterEffect10053ui_story = arg_51_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10053ui_story"]) then
				if arg_51_1.var_.characterEffect10053ui_story and not isNil(arg_51_1.actors_["10053ui_story"]) then
					arg_51_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10053ui_story"]) and arg_51_1.var_.characterEffect10053ui_story then
				arg_51_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_54_2 = arg_51_1.actors_["1058ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1058ui_story == nil then
				arg_51_1.var_.characterEffect1058ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect1058ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1058ui_story then
				arg_51_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_54_4 = "K04f_blur"

			if arg_51_1.bgs_.K04f_blur == nil then
				local var_54_5 = Object.Instantiate(arg_51_1.blurPaintGo_)

				var_54_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_54_4)
				var_54_5.name = var_54_4
				var_54_5.transform.parent = arg_51_1.stage_.transform
				var_54_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_[var_54_4] = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = arg_51_1.bgs_[var_54_4]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				var_54_7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_8 = var_54_7:GetComponent("SpriteRenderer")

				if var_54_8 and var_54_8.sprite then
					local var_54_9 = 2 * (var_54_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_7.transform.localScale = Vector3.New(var_54_9 / var_54_8.sprite.bounds.size.y < var_54_9 * manager.ui.mainCameraCom_.aspect / var_54_8.sprite.bounds.size.x and var_54_9 * manager.ui.mainCameraCom_.aspect / var_54_8.sprite.bounds.size.x or var_54_9 / var_54_8.sprite.bounds.size.y, var_54_9 / var_54_8.sprite.bounds.size.y < var_54_9 * manager.ui.mainCameraCom_.aspect / var_54_8.sprite.bounds.size.x and var_54_9 * manager.ui.mainCameraCom_.aspect / var_54_8.sprite.bounds.size.x or var_54_9 / var_54_8.sprite.bounds.size.y, 0)
				end
			end

			local var_54_10 = 0.2

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_10 then
				local var_54_11 = Color.New(1, 1, 1)

				var_54_11.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_6) / var_54_10)

				var_54_7:GetComponent("SpriteRenderer").material:SetColor("_Color", var_54_11)
			end

			local var_54_12 = arg_51_1.actors_["10053ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10053ui_story = var_54_12.localPosition
			end

			local var_54_13 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_13 then
				var_54_12.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_51_1.time_ - 0) / var_54_13)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_13 and arg_51_1.time_ < 0 + var_54_13 + arg_54_0 then
				var_54_12.localPosition = Vector3.New(0, -1.12, -5.99)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			local var_54_14 = 0
			local var_54_15 = 0.125

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_16 = arg_51_1:GetWordFromCfg(318192012)
				local var_54_17 = arg_51_1:FormatText(var_54_16.content)

				arg_51_1.text_.text = var_54_17

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 5 <= 0 and var_54_15 or var_54_15 * (utf8.len(var_54_17) / 5)

				if (5 <= 0 and var_54_15 or var_54_15 * (utf8.len(var_54_17) / 5)) > 0 and var_54_15 < var_54_19 then
					arg_51_1.talkMaxDuration = var_54_19

					if var_54_19 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_14
					end
				end

				arg_51_1.text_.text = var_54_17
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192012", "story_v_out_318192.awb") ~= 0 then
					local var_54_20 = manager.audio:GetVoiceLength("story_v_out_318192", "318192012", "story_v_out_318192.awb") / 1000

					if var_54_20 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_20 + var_54_14
					end

					if var_54_16.prefab_name ~= "" and arg_51_1.actors_[var_54_16.prefab_name] ~= nil then
						local var_54_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_16.prefab_name].transform, "story_v_out_318192", "318192012", "story_v_out_318192.awb")

						arg_51_1:RecordAudio("318192012", var_54_21)
						arg_51_1:RecordAudio("318192012", var_54_21)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_318192", "318192012", "story_v_out_318192.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_318192", "318192012", "story_v_out_318192.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_15, arg_51_1.talkMaxDuration)

			if var_54_14 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_14) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_14 + var_54_22 and arg_51_1.time_ < var_54_14 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play318192013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 318192013
		arg_55_1.duration_ = 3.9

		local var_55_0 = {
			zh = 1.666,
			ja = 3.9
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play318192014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1058ui_story"]) and arg_55_1.var_.characterEffect1058ui_story == nil then
				arg_55_1.var_.characterEffect1058ui_story = arg_55_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1058ui_story"]) then
				if arg_55_1.var_.characterEffect1058ui_story and not isNil(arg_55_1.actors_["1058ui_story"]) then
					arg_55_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1058ui_story"]) and arg_55_1.var_.characterEffect1058ui_story then
				arg_55_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["10053ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect10053ui_story == nil then
				arg_55_1.var_.characterEffect10053ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect10053ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect10053ui_story then
				arg_55_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_58_4 = 0
			local var_58_5 = 0.2

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_6 = arg_55_1:GetWordFromCfg(318192013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 8 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 8)

				if (8 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 8)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192013", "story_v_out_318192.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_318192", "318192013", "story_v_out_318192.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_318192", "318192013", "story_v_out_318192.awb")

						arg_55_1:RecordAudio("318192013", var_58_11)
						arg_55_1:RecordAudio("318192013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_318192", "318192013", "story_v_out_318192.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_318192", "318192013", "story_v_out_318192.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play318192014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 318192014
		arg_59_1.duration_ = 2.03

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play318192015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10053ui_story"]) and arg_59_1.var_.characterEffect10053ui_story == nil then
				arg_59_1.var_.characterEffect10053ui_story = arg_59_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10053ui_story"]) then
				if arg_59_1.var_.characterEffect10053ui_story and not isNil(arg_59_1.actors_["10053ui_story"]) then
					arg_59_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10053ui_story"]) and arg_59_1.var_.characterEffect10053ui_story then
				arg_59_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_2 = arg_59_1.actors_["1058ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1058ui_story == nil then
				arg_59_1.var_.characterEffect1058ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect1058ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1058ui_story then
				arg_59_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_62_4 = 0
			local var_62_5 = 0.1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(318192014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 4 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 4)

				if (4 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 4)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192014", "story_v_out_318192.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_318192", "318192014", "story_v_out_318192.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_318192", "318192014", "story_v_out_318192.awb")

						arg_59_1:RecordAudio("318192014", var_62_11)
						arg_59_1:RecordAudio("318192014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_318192", "318192014", "story_v_out_318192.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_318192", "318192014", "story_v_out_318192.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play318192015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318192015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318192016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10053ui_story"]) and arg_63_1.var_.characterEffect10053ui_story == nil then
				arg_63_1.var_.characterEffect10053ui_story = arg_63_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10053ui_story"]) then
				if arg_63_1.var_.characterEffect10053ui_story and not isNil(arg_63_1.actors_["10053ui_story"]) then
					arg_63_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10053ui_story"]) and arg_63_1.var_.characterEffect10053ui_story then
				arg_63_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 1.325

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(318192015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 53 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 53)

				if (53 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 53)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play318192016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318192016
		arg_67_1.duration_ = 5.23

		local var_67_0 = {
			zh = 5.233,
			ja = 3.866
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318192017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10053ui_story"]) and arg_67_1.var_.characterEffect10053ui_story == nil then
				arg_67_1.var_.characterEffect10053ui_story = arg_67_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10053ui_story"]) then
				if arg_67_1.var_.characterEffect10053ui_story and not isNil(arg_67_1.actors_["10053ui_story"]) then
					arg_67_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10053ui_story"]) and arg_67_1.var_.characterEffect10053ui_story then
				arg_67_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(318192016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 9 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 9)

				if (9 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 9)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192016", "story_v_out_318192.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_318192", "318192016", "story_v_out_318192.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_318192", "318192016", "story_v_out_318192.awb")

						arg_67_1:RecordAudio("318192016", var_70_9)
						arg_67_1:RecordAudio("318192016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_318192", "318192016", "story_v_out_318192.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_318192", "318192016", "story_v_out_318192.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play318192017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318192017
		arg_71_1.duration_ = 4.47

		local var_71_0 = {
			zh = 3.633,
			ja = 4.466
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play318192018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action15_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_0 = 0
			local var_74_1 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(318192017)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 16 <= 0 and var_74_1 or var_74_1 * (utf8.len(var_74_3) / 16)

				if (16 <= 0 and var_74_1 or var_74_1 * (utf8.len(var_74_3) / 16)) > 0 and var_74_1 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192017", "story_v_out_318192.awb") ~= 0 then
					local var_74_6 = manager.audio:GetVoiceLength("story_v_out_318192", "318192017", "story_v_out_318192.awb") / 1000

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end

					if var_74_2.prefab_name ~= "" and arg_71_1.actors_[var_74_2.prefab_name] ~= nil then
						local var_74_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_2.prefab_name].transform, "story_v_out_318192", "318192017", "story_v_out_318192.awb")

						arg_71_1:RecordAudio("318192017", var_74_7)
						arg_71_1:RecordAudio("318192017", var_74_7)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_318192", "318192017", "story_v_out_318192.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_318192", "318192017", "story_v_out_318192.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_8 and arg_71_1.time_ < var_74_0 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play318192018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 318192018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play318192019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10053ui_story"]) and arg_75_1.var_.characterEffect10053ui_story == nil then
				arg_75_1.var_.characterEffect10053ui_story = arg_75_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10053ui_story"]) then
				if arg_75_1.var_.characterEffect10053ui_story and not isNil(arg_75_1.actors_["10053ui_story"]) then
					arg_75_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10053ui_story"]) and arg_75_1.var_.characterEffect10053ui_story then
				arg_75_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(318192018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 59 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 59)

				if (59 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 59)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play318192019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 318192019
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play318192020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1058ui_story"]) and arg_79_1.var_.characterEffect1058ui_story == nil then
				arg_79_1.var_.characterEffect1058ui_story = arg_79_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1058ui_story"]) then
				if arg_79_1.var_.characterEffect1058ui_story and not isNil(arg_79_1.actors_["1058ui_story"]) then
					arg_79_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1058ui_story"]) and arg_79_1.var_.characterEffect1058ui_story then
				arg_79_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_82_2 = arg_79_1.actors_["10053ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10053ui_story = var_82_2.localPosition
			end

			local var_82_3 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10053ui_story, Vector3.New(-0.7, -1.12, -5.99), (arg_79_1.time_ - 0) / var_82_3)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(-0.7, -1.12, -5.99)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			local var_82_4 = arg_79_1.actors_["1058ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1058ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action15_2")
			end

			local var_82_6 = arg_79_1.actors_["10053ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10053ui_story == nil then
				arg_79_1.var_.characterEffect10053ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_7 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 and not isNil(var_82_6) then
				if arg_79_1.var_.characterEffect10053ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_7)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10053ui_story then
				arg_79_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_82_8 = 0
			local var_82_9 = 0.05

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(318192019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 2 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 2)

				if (2 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 2)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192019", "story_v_out_318192.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_318192", "318192019", "story_v_out_318192.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_318192", "318192019", "story_v_out_318192.awb")

						arg_79_1:RecordAudio("318192019", var_82_15)
						arg_79_1:RecordAudio("318192019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_318192", "318192019", "story_v_out_318192.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_318192", "318192019", "story_v_out_318192.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play318192020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 318192020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play318192021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) and arg_83_1.var_.characterEffect1058ui_story == nil then
				arg_83_1.var_.characterEffect1058ui_story = arg_83_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) then
				if arg_83_1.var_.characterEffect1058ui_story and not isNil(arg_83_1.actors_["1058ui_story"]) then
					arg_83_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) and arg_83_1.var_.characterEffect1058ui_story then
				arg_83_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.95

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(318192020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 38 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 38)

				if (38 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 38)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play318192021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318192021
		arg_87_1.duration_ = 9

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play318192022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.LX0202 == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0202")
				var_90_0.name = "LX0202"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.LX0202 = var_90_0
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.LX0202

				arg_87_1.bgs_.LX0202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "LX0202" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_5 = 2

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_5 then
				local var_90_6 = Color.New(1, 1, 1)

				var_90_6.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_4) / var_90_5)
				arg_87_1.mask_.color = var_90_6
			end

			if arg_87_1.time_ >= var_90_4 + var_90_5 and arg_87_1.time_ < var_90_4 + var_90_5 + arg_90_0 then
				local var_90_7 = Color.New(1, 1, 1)

				var_90_7.a = 1
				arg_87_1.mask_.color = var_90_7
			end

			local var_90_8 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_9 = 2

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 then
				local var_90_10 = Color.New(0.9528302, 0.9123799, 0.9123799)

				var_90_10.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_8) / var_90_9)
				arg_87_1.mask_.color = var_90_10
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 then
				local var_90_11 = Color.New(0.9528302, 0.9123799, 0.9123799)

				arg_87_1.mask_.enabled = false
				var_90_11.a = 0
				arg_87_1.mask_.color = var_90_11
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_wind", "")
			end

			local var_90_13 = arg_87_1.actors_["1058ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1058ui_story = var_90_13.localPosition
			end

			local var_90_14 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_14 then
				var_90_13.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_14)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_14 and arg_87_1.time_ < 0 + var_90_14 + arg_90_0 then
				var_90_13.localPosition = Vector3.New(0, 100, 0)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			local var_90_15 = arg_87_1.actors_["1058ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1058ui_story == nil then
				arg_87_1.var_.characterEffect1058ui_story = var_90_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_16 and not isNil(var_90_15) then
				if arg_87_1.var_.characterEffect1058ui_story and not isNil(var_90_15) then
					arg_87_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_16)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_16 and arg_87_1.time_ < 0 + var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1058ui_story then
				arg_87_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_90_17 = arg_87_1.actors_["10053ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10053ui_story = var_90_17.localPosition
			end

			local var_90_18 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_18 then
				var_90_17.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_18)
				var_90_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_17.position).x, (manager.ui.mainCamera.transform.position - var_90_17.position).y, (manager.ui.mainCamera.transform.position - var_90_17.position).z)
				var_90_17.localEulerAngles.z = 0
				var_90_17.localEulerAngles.x = 0
				var_90_17.localEulerAngles = var_90_17.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_18 and arg_87_1.time_ < 0 + var_90_18 + arg_90_0 then
				var_90_17.localPosition = Vector3.New(0, 100, 0)
				var_90_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_17.position).x, (manager.ui.mainCamera.transform.position - var_90_17.position).y, (manager.ui.mainCamera.transform.position - var_90_17.position).z)
				var_90_17.localEulerAngles.z = 0
				var_90_17.localEulerAngles.x = 0
				var_90_17.localEulerAngles = var_90_17.localEulerAngles
			end

			local var_90_19 = arg_87_1.bgs_.LX0202.transform

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				arg_87_1.var_.moveOldPosLX0202 = var_90_19.localPosition
			end

			local var_90_20 = 0.001

			if 2 <= arg_87_1.time_ and arg_87_1.time_ < 2 + var_90_20 then
				var_90_19.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosLX0202, Vector3.New(-0.5, 1, 8), (arg_87_1.time_ - 2) / var_90_20)
			end

			if arg_87_1.time_ >= 2 + var_90_20 and arg_87_1.time_ < 2 + var_90_20 + arg_90_0 then
				var_90_19.localPosition = Vector3.New(-0.5, 1, 8)
			end

			local var_90_21 = arg_87_1.bgs_.LX0202.transform

			if 2.034 < arg_87_1.time_ and arg_87_1.time_ <= 2.034 + arg_90_0 then
				arg_87_1.var_.moveOldPosLX0202 = var_90_21.localPosition
			end

			local var_90_22 = 3.5

			if 2.034 <= arg_87_1.time_ and arg_87_1.time_ < 2.034 + var_90_22 then
				var_90_21.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosLX0202, Vector3.New(0.5, 1, 8), (arg_87_1.time_ - 2.034) / var_90_22)
			end

			if arg_87_1.time_ >= 2.034 + var_90_22 and arg_87_1.time_ < 2.034 + var_90_22 + arg_90_0 then
				var_90_21.localPosition = Vector3.New(0.5, 1, 8)
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_23 = 4
			local var_90_24 = 0.325

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_25 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_25:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_26 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(318192021).content)

				arg_87_1.text_.text = var_90_26

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_28 = 13 <= 0 and var_90_24 or var_90_24 * (utf8.len(var_90_26) / 13)

				if (13 <= 0 and var_90_24 or var_90_24 * (utf8.len(var_90_26) / 13)) > 0 and var_90_24 < var_90_28 then
					arg_87_1.talkMaxDuration = var_90_28
					var_90_23 = var_90_23 + 0.3

					if var_90_28 + var_90_23 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_28 + var_90_23
					end
				end

				arg_87_1.text_.text = var_90_26
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_29 = var_90_23 + 0.3
			local var_90_30 = math.max(var_90_24, arg_87_1.talkMaxDuration)

			if var_90_23 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_29 + var_90_30 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_29) / var_90_30

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_29 + var_90_30 and arg_87_1.time_ < var_90_29 + var_90_30 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "LX0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play318192022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318192022
		arg_93_1.duration_ = 7

		local var_93_0 = {
			zh = 6.433,
			ja = 7
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play318192023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.7

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(318192022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 28 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 28)

				if (28 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 28)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192022", "story_v_out_318192.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_318192", "318192022", "story_v_out_318192.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_318192", "318192022", "story_v_out_318192.awb")

						arg_93_1:RecordAudio("318192022", var_96_6)
						arg_93_1:RecordAudio("318192022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318192", "318192022", "story_v_out_318192.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318192", "318192022", "story_v_out_318192.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play318192023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318192023
		arg_97_1.duration_ = 2.3

		local var_97_0 = {
			zh = 1.2,
			ja = 2.3
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play318192024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(318192023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 5 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 5)

				if (5 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 5)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192023", "story_v_out_318192.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_318192", "318192023", "story_v_out_318192.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_318192", "318192023", "story_v_out_318192.awb")

						arg_97_1:RecordAudio("318192023", var_100_6)
						arg_97_1:RecordAudio("318192023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318192", "318192023", "story_v_out_318192.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318192", "318192023", "story_v_out_318192.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play318192024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318192024
		arg_101_1.duration_ = 4.17

		local var_101_0 = {
			zh = 2.8,
			ja = 4.166
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play318192025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.35

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(318192024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 14 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 14)

				if (14 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 14)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192024", "story_v_out_318192.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_318192", "318192024", "story_v_out_318192.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_318192", "318192024", "story_v_out_318192.awb")

						arg_101_1:RecordAudio("318192024", var_104_6)
						arg_101_1:RecordAudio("318192024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318192", "318192024", "story_v_out_318192.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318192", "318192024", "story_v_out_318192.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318192025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318192025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318192026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_0 = 0.6

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				local var_108_1 = Color.New(1, 1, 1)

				var_108_1.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.mask_.color = var_108_1
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				local var_108_2 = Color.New(1, 1, 1)

				arg_105_1.mask_.enabled = false
				var_108_2.a = 0
				arg_105_1.mask_.color = var_108_2
			end

			local var_108_3 = manager.ui.mainCamera.transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.shakeOldPos = var_108_3.localPosition
			end

			local var_108_4 = 0.6

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				local var_108_5, var_108_6 = math.modf((arg_105_1.time_ - 0) / 0.066)

				var_108_3.localPosition = Vector3.New(var_108_6 * 0.13, var_108_6 * 0.13, var_108_6 * 0.13) + arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = arg_105_1.var_.shakeOldPos
			end

			local var_108_7 = arg_105_1.bgs_.LX0202.transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPosLX0202 = var_108_7.localPosition
			end

			local var_108_8 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_8 then
				var_108_7.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPosLX0202, Vector3.New(0, 1, 9.5), (arg_105_1.time_ - 0) / var_108_8)
			end

			if arg_105_1.time_ >= 0 + var_108_8 and arg_105_1.time_ < 0 + var_108_8 + arg_108_0 then
				var_108_7.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_108_9 = arg_105_1.bgs_.LX0202.transform

			if 0.0166666666666667 < arg_105_1.time_ and arg_105_1.time_ <= 0.0166666666666667 + arg_108_0 then
				arg_105_1.var_.moveOldPosLX0202 = var_108_9.localPosition
			end

			local var_108_10 = 3

			if 0.0166666666666667 <= arg_105_1.time_ and arg_105_1.time_ < 0.0166666666666667 + var_108_10 then
				var_108_9.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPosLX0202, Vector3.New(0, 1, 10), (arg_105_1.time_ - 0.0166666666666667) / var_108_10)
			end

			if arg_105_1.time_ >= 0.0166666666666667 + var_108_10 and arg_105_1.time_ < 0.0166666666666667 + var_108_10 + arg_108_0 then
				var_108_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_108_11 = 0.6

			if 0.6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_11 + 2.41666666666667 and arg_105_1.time_ < var_108_11 + 2.41666666666667 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_12 = 0
			local var_108_13 = 1.025

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(318192025).content)

				arg_105_1.text_.text = var_108_14

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 41 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_14) / 41)

				if (41 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_14) / 41)) > 0 and var_108_13 < var_108_16 then
					arg_105_1.talkMaxDuration = var_108_16

					if var_108_16 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_14
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_17 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_17 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_17

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_17 and arg_105_1.time_ < var_108_12 + var_108_17 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play318192026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318192026
		arg_109_1.duration_ = 3.87

		local var_109_0 = {
			zh = 3.433,
			ja = 3.866
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play318192027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(318192026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 14 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 14)

				if (14 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 14)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192026", "story_v_out_318192.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_318192", "318192026", "story_v_out_318192.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_318192", "318192026", "story_v_out_318192.awb")

						arg_109_1:RecordAudio("318192026", var_112_6)
						arg_109_1:RecordAudio("318192026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318192", "318192026", "story_v_out_318192.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318192", "318192026", "story_v_out_318192.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play318192027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318192027
		arg_113_1.duration_ = 5.67

		local var_113_0 = {
			zh = 5.666,
			ja = 3.433
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
			arg_113_1.auto_ = false
		end

		function arg_113_1.playNext_(arg_115_0)
			arg_113_1.onStoryFinished_()
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(318192027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)

				if (22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318192", "318192027", "story_v_out_318192.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_318192", "318192027", "story_v_out_318192.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_318192", "318192027", "story_v_out_318192.awb")

						arg_113_1:RecordAudio("318192027", var_116_6)
						arg_113_1:RecordAudio("318192027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318192", "318192027", "story_v_out_318192.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318192", "318192027", "story_v_out_318192.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K04f",
		"TextureConfig/Background/K04f_blur",
		"TextureConfig/Background/LX0202"
	},
	voices = {
		"story_v_out_318192.awb"
	}
}

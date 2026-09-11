return {
	Play320271001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320271001
		arg_1_1.duration_ = 6.28

		local var_1_0 = {
			zh = 4.68118581147864,
			ja = 6.28118581147864
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320271002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST61 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_4_0.name = "ST61"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST61 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST61

				arg_1_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1061ui_story"

			if arg_1_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1061ui_story"].transform

			if 1.88118581147864 < arg_1_1.time_ and arg_1_1.time_ <= 1.88118581147864 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.88118581147864 <= arg_1_1.time_ and arg_1_1.time_ < 1.88118581147864 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_1_1.time_ - 1.88118581147864) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.88118581147864 + var_4_14 and arg_1_1.time_ < 1.88118581147864 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1061ui_story"]

			if 1.88118581147864 < arg_1_1.time_ and arg_1_1.time_ <= 1.88118581147864 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.88118581147864 <= arg_1_1.time_ and arg_1_1.time_ < 1.88118581147864 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.88118581147864 + var_4_16 and arg_1_1.time_ < 1.88118581147864 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.88118581147864 < arg_1_1.time_ and arg_1_1.time_ <= 1.88118581147864 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.88118581147864 < arg_1_1.time_ and arg_1_1.time_ <= 1.88118581147864 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 1.88118581147864
			local var_4_25 = 0.3

			if 1.88118581147864 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(320271001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 12 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 12)

				if (12 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 12)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271001", "story_v_out_320271.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_320271", "320271001", "story_v_out_320271.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_320271", "320271001", "story_v_out_320271.awb")

						arg_1_1:RecordAudio("320271001", var_4_32)
						arg_1_1:RecordAudio("320271001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320271", "320271001", "story_v_out_320271.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320271", "320271001", "story_v_out_320271.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.88118581147864,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320271002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320271002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320271003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1061ui_story"]) and arg_9_1.var_.characterEffect1061ui_story == nil then
				arg_9_1.var_.characterEffect1061ui_story = arg_9_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1061ui_story"]) then
				if arg_9_1.var_.characterEffect1061ui_story and not isNil(arg_9_1.actors_["1061ui_story"]) then
					arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1061ui_story"]) and arg_9_1.var_.characterEffect1061ui_story then
				arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(320271002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 45 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 45)

				if (45 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 45)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play320271003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320271003
		arg_13_1.duration_ = 8.3

		local var_13_0 = {
			zh = 5.2,
			ja = 8.3
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
				arg_13_0:Play320271004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1061ui_story"]) and arg_13_1.var_.characterEffect1061ui_story == nil then
				arg_13_1.var_.characterEffect1061ui_story = arg_13_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1061ui_story"]) then
				if arg_13_1.var_.characterEffect1061ui_story and not isNil(arg_13_1.actors_["1061ui_story"]) then
					arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1061ui_story"]) and arg_13_1.var_.characterEffect1061ui_story then
				arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_2 = 0
			local var_16_3 = 0.675

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(320271003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 27 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 27)

				if (27 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 27)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271003", "story_v_out_320271.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271003", "story_v_out_320271.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_320271", "320271003", "story_v_out_320271.awb")

						arg_13_1:RecordAudio("320271003", var_16_9)
						arg_13_1:RecordAudio("320271003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320271", "320271003", "story_v_out_320271.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320271", "320271003", "story_v_out_320271.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play320271004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320271004
		arg_17_1.duration_ = 3.93

		local var_17_0 = {
			zh = 3.933,
			ja = 1.999999999999
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
				arg_17_0:Play320271005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1089ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1089ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1089ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1089ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1089ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1089ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1089ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1089ui_story == nil then
				arg_17_1.var_.characterEffect1089ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1089ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1089ui_story then
				arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_20_8 = arg_17_1.actors_["1061ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0, 100, 0)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			local var_20_10 = arg_17_1.actors_["1061ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1061ui_story then
				arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_20_12 = 0
			local var_20_13 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(320271004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 14 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 14)

				if (14 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 14)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271004", "story_v_out_320271.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_320271", "320271004", "story_v_out_320271.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_320271", "320271004", "story_v_out_320271.awb")

						arg_17_1:RecordAudio("320271004", var_20_19)
						arg_17_1:RecordAudio("320271004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320271", "320271004", "story_v_out_320271.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320271", "320271004", "story_v_out_320271.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play320271005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320271005
		arg_21_1.duration_ = 2.97

		local var_21_0 = {
			zh = 2.966,
			ja = 2.466
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
				arg_21_0:Play320271006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061ui_story = arg_21_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).z)
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles = arg_21_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_21_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1061ui_story"].transform.position).z)
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1061ui_story"].transform.localEulerAngles = arg_21_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1061ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1061ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action425")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_24_4 = arg_21_1.actors_["1089ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1089ui_story = var_24_4.localPosition
			end

			local var_24_5 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 then
				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_5)
				var_24_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_4.position).x, (manager.ui.mainCamera.transform.position - var_24_4.position).y, (manager.ui.mainCamera.transform.position - var_24_4.position).z)
				var_24_4.localEulerAngles.z = 0
				var_24_4.localEulerAngles.x = 0
				var_24_4.localEulerAngles = var_24_4.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, 100, 0)
				var_24_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_4.position).x, (manager.ui.mainCamera.transform.position - var_24_4.position).y, (manager.ui.mainCamera.transform.position - var_24_4.position).z)
				var_24_4.localEulerAngles.z = 0
				var_24_4.localEulerAngles.x = 0
				var_24_4.localEulerAngles = var_24_4.localEulerAngles
			end

			local var_24_6 = arg_21_1.actors_["1089ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1089ui_story == nil then
				arg_21_1.var_.characterEffect1089ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 and not isNil(var_24_6) then
				if arg_21_1.var_.characterEffect1089ui_story and not isNil(var_24_6) then
					arg_21_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_7)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1089ui_story then
				arg_21_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_24_8 = 0
			local var_24_9 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(320271005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 7 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 7)

				if (7 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 7)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271005", "story_v_out_320271.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_320271", "320271005", "story_v_out_320271.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_320271", "320271005", "story_v_out_320271.awb")

						arg_21_1:RecordAudio("320271005", var_24_15)
						arg_21_1:RecordAudio("320271005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320271", "320271005", "story_v_out_320271.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320271", "320271005", "story_v_out_320271.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play320271006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320271006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320271007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061ui_story = arg_25_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).z)
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles = arg_25_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1061ui_story"].transform.position).z)
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1061ui_story"].transform.localEulerAngles = arg_25_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1061ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1061ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(320271006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 41 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 41)

				if (41 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 41)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play320271007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320271007
		arg_29_1.duration_ = 9.67

		local var_29_0 = {
			zh = 8.5,
			ja = 9.666
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
				arg_29_0:Play320271008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061ui_story = arg_29_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).z)
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles = arg_29_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_29_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1061ui_story"].transform.position).z)
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1061ui_story"].transform.localEulerAngles = arg_29_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1061ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1061ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_32_4 = 0
			local var_32_5 = 1.05

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(320271007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 42 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 42)

				if (42 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 42)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271007", "story_v_out_320271.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_320271", "320271007", "story_v_out_320271.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_320271", "320271007", "story_v_out_320271.awb")

						arg_29_1:RecordAudio("320271007", var_32_11)
						arg_29_1:RecordAudio("320271007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320271", "320271007", "story_v_out_320271.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320271", "320271007", "story_v_out_320271.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play320271008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320271008
		arg_33_1.duration_ = 8.1

		local var_33_0 = {
			zh = 3.2,
			ja = 8.1
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play320271009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1089ui_story = arg_33_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1089ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1089ui_story == nil then
				arg_33_1.var_.characterEffect1089ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1089ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1089ui_story then
				arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1061ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061ui_story = var_36_4.localPosition
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_4.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_5)
				var_36_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_4.position).x, (manager.ui.mainCamera.transform.position - var_36_4.position).y, (manager.ui.mainCamera.transform.position - var_36_4.position).z)
				var_36_4.localEulerAngles.z = 0
				var_36_4.localEulerAngles.x = 0
				var_36_4.localEulerAngles = var_36_4.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				var_36_4.localPosition = Vector3.New(0, 100, 0)
				var_36_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_4.position).x, (manager.ui.mainCamera.transform.position - var_36_4.position).y, (manager.ui.mainCamera.transform.position - var_36_4.position).z)
				var_36_4.localEulerAngles.z = 0
				var_36_4.localEulerAngles.x = 0
				var_36_4.localEulerAngles = var_36_4.localEulerAngles
			end

			local var_36_6 = 0
			local var_36_7 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(320271008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)

				if (13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271008", "story_v_out_320271.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_320271", "320271008", "story_v_out_320271.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_320271", "320271008", "story_v_out_320271.awb")

						arg_33_1:RecordAudio("320271008", var_36_13)
						arg_33_1:RecordAudio("320271008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320271", "320271008", "story_v_out_320271.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320271", "320271008", "story_v_out_320271.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play320271009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320271009
		arg_37_1.duration_ = 10.1

		local var_37_0 = {
			zh = 8.3,
			ja = 10.1
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320271010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_40_0 = 0
			local var_40_1 = 0.95

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(320271009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 38 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 38)

				if (38 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 38)) > 0 and var_40_1 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271009", "story_v_out_320271.awb") ~= 0 then
					local var_40_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271009", "story_v_out_320271.awb") / 1000

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end

					if var_40_2.prefab_name ~= "" and arg_37_1.actors_[var_40_2.prefab_name] ~= nil then
						local var_40_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_2.prefab_name].transform, "story_v_out_320271", "320271009", "story_v_out_320271.awb")

						arg_37_1:RecordAudio("320271009", var_40_7)
						arg_37_1:RecordAudio("320271009", var_40_7)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320271", "320271009", "story_v_out_320271.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320271", "320271009", "story_v_out_320271.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320271010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320271010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320271011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1089ui_story = arg_41_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).z)
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles = arg_41_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1089ui_story"].transform.position).z)
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1089ui_story"].transform.localEulerAngles = arg_41_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_44_1 = 0
			local var_44_2 = 1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(320271010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 40 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 40)

				if (40 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 40)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play320271011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320271011
		arg_45_1.duration_ = 7.73

		local var_45_0 = {
			zh = 5.133,
			ja = 7.733
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320271012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_48_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_45_1.stage_.transform)

				var_48_0.name = "1056ui_story"
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1056ui_story"] = var_48_0

				local var_48_1 = var_48_0:GetComponentInChildren(typeof(CharacterEffect))

				var_48_1.enabled = true

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_1.transform, false)

				arg_45_1.var_["1056ui_story" .. "Animator"] = var_48_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_45_1.var_["1056ui_story" .. "LipSync"] = var_48_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_3 = arg_45_1.actors_["1056ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1056ui_story = var_48_3.localPosition
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_3.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_45_1.time_ - 0) / var_48_4)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_3.localPosition = Vector3.New(0, -1, -5.75)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			local var_48_5 = arg_45_1.actors_["1056ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1056ui_story == nil then
				arg_45_1.var_.characterEffect1056ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.characterEffect1056ui_story and not isNil(var_48_5) then
					arg_45_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1056ui_story then
				arg_45_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_48_8 = 0
			local var_48_9 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(320271011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 26 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 26)

				if (26 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 26)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271011", "story_v_out_320271.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_320271", "320271011", "story_v_out_320271.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_320271", "320271011", "story_v_out_320271.awb")

						arg_45_1:RecordAudio("320271011", var_48_15)
						arg_45_1:RecordAudio("320271011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320271", "320271011", "story_v_out_320271.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320271", "320271011", "story_v_out_320271.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play320271012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320271012
		arg_49_1.duration_ = 11.27

		local var_49_0 = {
			zh = 7.5,
			ja = 11.266
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320271013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(320271012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 40 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 40)

				if (40 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 40)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271012", "story_v_out_320271.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271012", "story_v_out_320271.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_320271", "320271012", "story_v_out_320271.awb")

						arg_49_1:RecordAudio("320271012", var_52_6)
						arg_49_1:RecordAudio("320271012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320271", "320271012", "story_v_out_320271.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320271", "320271012", "story_v_out_320271.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320271013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320271013
		arg_53_1.duration_ = 8.1

		local var_53_0 = {
			zh = 8.1,
			ja = 5.7
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320271014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061ui_story = arg_53_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).z)
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles = arg_53_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_53_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1061ui_story"].transform.position).z)
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1061ui_story"].transform.localEulerAngles = arg_53_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1061ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1061ui_story == nil then
				arg_53_1.var_.characterEffect1061ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1061ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1061ui_story then
				arg_53_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = arg_53_1.actors_["1056ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_5)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0, 100, 0)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			local var_56_6 = arg_53_1.actors_["1056ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1056ui_story == nil then
				arg_53_1.var_.characterEffect1056ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect1056ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1056ui_story then
				arg_53_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_56_8 = 0
			local var_56_9 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(320271013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 30 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 30)

				if (30 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 30)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271013", "story_v_out_320271.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_320271", "320271013", "story_v_out_320271.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_320271", "320271013", "story_v_out_320271.awb")

						arg_53_1:RecordAudio("320271013", var_56_15)
						arg_53_1:RecordAudio("320271013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320271", "320271013", "story_v_out_320271.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320271", "320271013", "story_v_out_320271.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play320271014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320271014
		arg_57_1.duration_ = 10.23

		local var_57_0 = {
			zh = 6.333,
			ja = 10.233
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play320271015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1056ui_story = arg_57_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).z)
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles = arg_57_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_57_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1056ui_story"].transform.position).z)
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1056ui_story"].transform.localEulerAngles = arg_57_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1056ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1056ui_story == nil then
				arg_57_1.var_.characterEffect1056ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1056ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1056ui_story then
				arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["1061ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061ui_story = var_60_4.localPosition
			end

			local var_60_5 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 then
				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_5)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, 100, 0)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			local var_60_6 = arg_57_1.actors_["1061ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect1061ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1061ui_story then
				arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_60_8 = 0
			local var_60_9 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(320271014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 34 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 34)

				if (34 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 34)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271014", "story_v_out_320271.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_320271", "320271014", "story_v_out_320271.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_320271", "320271014", "story_v_out_320271.awb")

						arg_57_1:RecordAudio("320271014", var_60_15)
						arg_57_1:RecordAudio("320271014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320271", "320271014", "story_v_out_320271.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320271", "320271014", "story_v_out_320271.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play320271015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320271015
		arg_61_1.duration_ = 5.87

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320271016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.bgs_.ST69 == nil then
				local var_64_0 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69")
				var_64_0.name = "ST69"
				var_64_0.transform.parent = arg_61_1.stage_.transform
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_.ST69 = var_64_0
			end

			if 1.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= 1.999999999999 + arg_64_0 then
				local var_64_1 = arg_61_1.bgs_.ST69

				arg_61_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_2 = var_64_1:GetComponent("SpriteRenderer")

				if var_64_2 and var_64_2.sprite then
					local var_64_3 = 2 * (var_64_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_1.transform.localScale = Vector3.New(var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST69" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_4 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_4 + 0.3 and arg_61_1.time_ < var_64_4 + 0.3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_5 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_6 = 2

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_5) / var_64_6)
				arg_61_1.mask_.color = var_64_7
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 then
				local var_64_8 = Color.New(0, 0, 0)

				var_64_8.a = 1
				arg_61_1.mask_.color = var_64_8
			end

			local var_64_9 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_10 = 2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 then
				local var_64_11 = Color.New(0, 0, 0)

				var_64_11.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_9) / var_64_10)
				arg_61_1.mask_.color = var_64_11
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 then
				local var_64_12 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_12.a = 0
				arg_61_1.mask_.color = var_64_12
			end

			local var_64_13 = arg_61_1.actors_["1061ui_story"].transform

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061ui_story = var_64_13.localPosition
			end

			local var_64_14 = 0.001

			if 3.86666666666667 <= arg_61_1.time_ and arg_61_1.time_ < 3.86666666666667 + var_64_14 then
				var_64_13.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_61_1.time_ - 3.86666666666667) / var_64_14)
				var_64_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_13.position).x, (manager.ui.mainCamera.transform.position - var_64_13.position).y, (manager.ui.mainCamera.transform.position - var_64_13.position).z)
				var_64_13.localEulerAngles.z = 0
				var_64_13.localEulerAngles.x = 0
				var_64_13.localEulerAngles = var_64_13.localEulerAngles
			end

			if arg_61_1.time_ >= 3.86666666666667 + var_64_14 and arg_61_1.time_ < 3.86666666666667 + var_64_14 + arg_64_0 then
				var_64_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_64_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_13.position).x, (manager.ui.mainCamera.transform.position - var_64_13.position).y, (manager.ui.mainCamera.transform.position - var_64_13.position).z)
				var_64_13.localEulerAngles.z = 0
				var_64_13.localEulerAngles.x = 0
				var_64_13.localEulerAngles = var_64_13.localEulerAngles
			end

			local var_64_15 = arg_61_1.actors_["1061ui_story"]

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect1061ui_story == nil then
				arg_61_1.var_.characterEffect1061ui_story = var_64_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_16 = 0.200000002980232

			if 3.86666666666667 <= arg_61_1.time_ and arg_61_1.time_ < 3.86666666666667 + var_64_16 and not isNil(var_64_15) then
				if arg_61_1.var_.characterEffect1061ui_story and not isNil(var_64_15) then
					arg_61_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 3.86666666666667 + var_64_16 and arg_61_1.time_ < 3.86666666666667 + var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect1061ui_story then
				arg_61_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 then
				arg_61_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 then
				arg_61_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_18 = arg_61_1.actors_["1056ui_story"].transform

			if 1.96666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 1.96666666666667 + arg_64_0 then
				arg_61_1.var_.moveOldPos1056ui_story = var_64_18.localPosition
			end

			local var_64_19 = 0.001

			if 1.96666666666667 <= arg_61_1.time_ and arg_61_1.time_ < 1.96666666666667 + var_64_19 then
				var_64_18.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 1.96666666666667) / var_64_19)
				var_64_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_18.position).x, (manager.ui.mainCamera.transform.position - var_64_18.position).y, (manager.ui.mainCamera.transform.position - var_64_18.position).z)
				var_64_18.localEulerAngles.z = 0
				var_64_18.localEulerAngles.x = 0
				var_64_18.localEulerAngles = var_64_18.localEulerAngles
			end

			if arg_61_1.time_ >= 1.96666666666667 + var_64_19 and arg_61_1.time_ < 1.96666666666667 + var_64_19 + arg_64_0 then
				var_64_18.localPosition = Vector3.New(0, 100, 0)
				var_64_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_18.position).x, (manager.ui.mainCamera.transform.position - var_64_18.position).y, (manager.ui.mainCamera.transform.position - var_64_18.position).z)
				var_64_18.localEulerAngles.z = 0
				var_64_18.localEulerAngles.x = 0
				var_64_18.localEulerAngles = var_64_18.localEulerAngles
			end

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 then
				if arg_61_1.var_.characterEffect1061ui_story == nil then
					arg_61_1.var_.characterEffect1061ui_story = arg_61_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_64_20 = arg_61_1.var_.characterEffect1061ui_story

				arg_61_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_64_20.interferenceEffect.enabled = true
				var_64_20.interferenceEffect.noise = 0.001
				var_64_20.interferenceEffect.simTimeScale = 1
				var_64_20.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.86666666666667 < arg_61_1.time_ and arg_61_1.time_ <= 3.86666666666667 + arg_64_0 then
				if arg_61_1.var_.characterEffect1061ui_story == nil then
					arg_61_1.var_.characterEffect1061ui_story = arg_61_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_61_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_64_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_61_1.bgmTxt_.text ~= var_64_24 and arg_61_1.bgmTxt_.text ~= "" then
						if arg_61_1.bgmTxt2_.text ~= "" then
							arg_61_1.bgmTxt_.text = arg_61_1.bgmTxt2_.text
						end

						arg_61_1.bgmTxt2_.text = var_64_24

						arg_61_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_61_1.bgmTxt_.text = var_64_24
						arg_61_1.bgmTxt2_.text = var_64_24
					end

					if arg_61_1.bgmTimer then
						arg_61_1.bgmTimer:Stop()

						arg_61_1.bgmTimer = nil
					end

					if arg_61_1.settingData.show_music_name == 1 then
						arg_61_1.musicController:SetSelectedState("show")
						arg_61_1.musicAnimator_:Play("open", 0, 0)

						if arg_61_1.settingData.music_time ~= 0 then
							arg_61_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_61_1.settingData.music_time), function()
								if arg_61_1 == nil or isNil(arg_61_1.bgmTxt_) then
									return
								end

								arg_61_1.musicController:SetSelectedState("hide")
								arg_61_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_61_1.time_ and arg_61_1.time_ <= 0.333333333333333 + arg_64_0 then
				arg_61_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_64_27 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_61_1.bgmTxt_.text ~= var_64_27 and arg_61_1.bgmTxt_.text ~= "" then
						if arg_61_1.bgmTxt2_.text ~= "" then
							arg_61_1.bgmTxt_.text = arg_61_1.bgmTxt2_.text
						end

						arg_61_1.bgmTxt2_.text = var_64_27

						arg_61_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_61_1.bgmTxt_.text = var_64_27
						arg_61_1.bgmTxt2_.text = var_64_27
					end

					if arg_61_1.bgmTimer then
						arg_61_1.bgmTimer:Stop()

						arg_61_1.bgmTimer = nil
					end

					if arg_61_1.settingData.show_music_name == 1 then
						arg_61_1.musicController:SetSelectedState("show")
						arg_61_1.musicAnimator_:Play("open", 0, 0)

						if arg_61_1.settingData.music_time ~= 0 then
							arg_61_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_61_1.settingData.music_time), function()
								if arg_61_1 == nil or isNil(arg_61_1.bgmTxt_) then
									return
								end

								arg_61_1.musicController:SetSelectedState("hide")
								arg_61_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_28 = 3.999999999999
			local var_64_29 = 0.125

			if 3.999999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_30 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_30:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_61_1.dialogCg_.alpha = arg_67_0
				end))
				var_64_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_31 = arg_61_1:GetWordFromCfg(320271015)
				local var_64_32 = arg_61_1:FormatText(var_64_31.content)

				arg_61_1.text_.text = var_64_32

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_34 = 5 <= 0 and var_64_29 or var_64_29 * (utf8.len(var_64_32) / 5)

				if (5 <= 0 and var_64_29 or var_64_29 * (utf8.len(var_64_32) / 5)) > 0 and var_64_29 < var_64_34 then
					arg_61_1.talkMaxDuration = var_64_34
					var_64_28 = var_64_28 + 0.3

					if var_64_34 + var_64_28 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_34 + var_64_28
					end
				end

				arg_61_1.text_.text = var_64_32
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271015", "story_v_out_320271.awb") ~= 0 then
					local var_64_35 = manager.audio:GetVoiceLength("story_v_out_320271", "320271015", "story_v_out_320271.awb") / 1000

					if var_64_35 + var_64_28 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_35 + var_64_28
					end

					if var_64_31.prefab_name ~= "" and arg_61_1.actors_[var_64_31.prefab_name] ~= nil then
						local var_64_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_31.prefab_name].transform, "story_v_out_320271", "320271015", "story_v_out_320271.awb")

						arg_61_1:RecordAudio("320271015", var_64_36)
						arg_61_1:RecordAudio("320271015", var_64_36)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320271", "320271015", "story_v_out_320271.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320271", "320271015", "story_v_out_320271.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_37 = var_64_28 + 0.3
			local var_64_38 = math.max(var_64_29, arg_61_1.talkMaxDuration)

			if var_64_28 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_37 + var_64_38 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_37) / var_64_38

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_37 + var_64_38 and arg_61_1.time_ < var_64_37 + var_64_38 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play320271016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320271016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320271017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1061ui_story"]) and arg_69_1.var_.characterEffect1061ui_story == nil then
				arg_69_1.var_.characterEffect1061ui_story = arg_69_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1061ui_story"]) then
				if arg_69_1.var_.characterEffect1061ui_story and not isNil(arg_69_1.actors_["1061ui_story"]) then
					arg_69_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1061ui_story"]) and arg_69_1.var_.characterEffect1061ui_story then
				arg_69_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320271016).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 12 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 12)

				if (12 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 12)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320271017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320271017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320271018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.075

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(320271017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 43 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 43)

				if (43 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 43)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320271018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320271018
		arg_77_1.duration_ = 6.13

		local var_77_0 = {
			zh = 6.133,
			ja = 5.266
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320271019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1061ui_story"]) and arg_77_1.var_.characterEffect1061ui_story == nil then
				arg_77_1.var_.characterEffect1061ui_story = arg_77_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1061ui_story"]) then
				if arg_77_1.var_.characterEffect1061ui_story and not isNil(arg_77_1.actors_["1061ui_story"]) then
					arg_77_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1061ui_story"]) and arg_77_1.var_.characterEffect1061ui_story then
				arg_77_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.8

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(320271018)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 32 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 32)

				if (32 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 32)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271018", "story_v_out_320271.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271018", "story_v_out_320271.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_320271", "320271018", "story_v_out_320271.awb")

						arg_77_1:RecordAudio("320271018", var_80_9)
						arg_77_1:RecordAudio("320271018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320271", "320271018", "story_v_out_320271.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320271", "320271018", "story_v_out_320271.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320271019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320271019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play320271020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1061ui_story"]) and arg_81_1.var_.characterEffect1061ui_story == nil then
				arg_81_1.var_.characterEffect1061ui_story = arg_81_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1061ui_story"]) then
				if arg_81_1.var_.characterEffect1061ui_story and not isNil(arg_81_1.actors_["1061ui_story"]) then
					arg_81_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1061ui_story"]) and arg_81_1.var_.characterEffect1061ui_story then
				arg_81_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.825

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(320271019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 33 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 33)

				if (33 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 33)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320271020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320271020
		arg_85_1.duration_ = 5.1

		local var_85_0 = {
			zh = 3.4,
			ja = 5.1
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320271021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1061ui_story"]) and arg_85_1.var_.characterEffect1061ui_story == nil then
				arg_85_1.var_.characterEffect1061ui_story = arg_85_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1061ui_story"]) then
				if arg_85_1.var_.characterEffect1061ui_story and not isNil(arg_85_1.actors_["1061ui_story"]) then
					arg_85_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1061ui_story"]) and arg_85_1.var_.characterEffect1061ui_story then
				arg_85_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_2 = 0
			local var_88_3 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(320271020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 20 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 20)

				if (20 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 20)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271020", "story_v_out_320271.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271020", "story_v_out_320271.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_320271", "320271020", "story_v_out_320271.awb")

						arg_85_1:RecordAudio("320271020", var_88_9)
						arg_85_1:RecordAudio("320271020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320271", "320271020", "story_v_out_320271.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320271", "320271020", "story_v_out_320271.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320271021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320271021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320271022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) and arg_89_1.var_.characterEffect1061ui_story == nil then
				arg_89_1.var_.characterEffect1061ui_story = arg_89_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) then
				if arg_89_1.var_.characterEffect1061ui_story and not isNil(arg_89_1.actors_["1061ui_story"]) then
					arg_89_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) and arg_89_1.var_.characterEffect1061ui_story then
				arg_89_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.55

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(320271021).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 22 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 22)

				if (22 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 22)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play320271022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320271022
		arg_93_1.duration_ = 15.47

		local var_93_0 = {
			zh = 15.3,
			ja = 15.466
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
				arg_93_0:Play320271023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1061ui_story"]) and arg_93_1.var_.characterEffect1061ui_story == nil then
				arg_93_1.var_.characterEffect1061ui_story = arg_93_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1061ui_story"]) then
				if arg_93_1.var_.characterEffect1061ui_story and not isNil(arg_93_1.actors_["1061ui_story"]) then
					arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1061ui_story"]) and arg_93_1.var_.characterEffect1061ui_story then
				arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_96_2 = 0
			local var_96_3 = 1.5

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(320271022)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 60 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 60)

				if (60 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 60)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271022", "story_v_out_320271.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271022", "story_v_out_320271.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_320271", "320271022", "story_v_out_320271.awb")

						arg_93_1:RecordAudio("320271022", var_96_9)
						arg_93_1:RecordAudio("320271022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320271", "320271022", "story_v_out_320271.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320271", "320271022", "story_v_out_320271.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320271023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320271023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320271024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1061ui_story = arg_97_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).z)
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles = arg_97_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1061ui_story"].transform.position).z)
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1061ui_story"].transform.localEulerAngles = arg_97_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_100_1 = 0
			local var_100_2 = 1.475

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(320271023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 59 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 59)

				if (59 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 59)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play320271024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320271024
		arg_101_1.duration_ = 1.9

		local var_101_0 = {
			zh = 1,
			ja = 1.9
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
				arg_101_0:Play320271025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(320271024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 2 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 2)

				if (2 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 2)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271024", "story_v_out_320271.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271024", "story_v_out_320271.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_320271", "320271024", "story_v_out_320271.awb")

						arg_101_1:RecordAudio("320271024", var_104_6)
						arg_101_1:RecordAudio("320271024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320271", "320271024", "story_v_out_320271.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320271", "320271024", "story_v_out_320271.awb")
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
	Play320271025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320271025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320271026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(320271025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 10 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 10)

				if (10 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 10)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320271026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320271026
		arg_109_1.duration_ = 3.93

		local var_109_0 = {
			zh = 2.133,
			ja = 3.933
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
				arg_109_0:Play320271027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(320271026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 13 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 13)

				if (13 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 13)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271026", "story_v_out_320271.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271026", "story_v_out_320271.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_320271", "320271026", "story_v_out_320271.awb")

						arg_109_1:RecordAudio("320271026", var_112_6)
						arg_109_1:RecordAudio("320271026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320271", "320271026", "story_v_out_320271.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320271", "320271026", "story_v_out_320271.awb")
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
	Play320271027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320271027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320271028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(320271027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 31 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 31)

				if (31 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 31)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320271028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320271028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play320271029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.15

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(320271028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 6 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 6)

				if (6 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 6)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play320271029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320271029
		arg_121_1.duration_ = 3.4

		local var_121_0 = {
			zh = 1.466,
			ja = 3.4
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320271030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(320271029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 9)

				if (9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 9)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271029", "story_v_out_320271.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271029", "story_v_out_320271.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_320271", "320271029", "story_v_out_320271.awb")

						arg_121_1:RecordAudio("320271029", var_124_6)
						arg_121_1:RecordAudio("320271029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320271", "320271029", "story_v_out_320271.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320271", "320271029", "story_v_out_320271.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play320271030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320271030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play320271031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(320271030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 48 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 48)

				if (48 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 48)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320271031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320271031
		arg_129_1.duration_ = 11.4

		local var_129_0 = {
			zh = 8,
			ja = 11.4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play320271032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(320271031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 40)

				if (40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 40)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271031", "story_v_out_320271.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271031", "story_v_out_320271.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_320271", "320271031", "story_v_out_320271.awb")

						arg_129_1:RecordAudio("320271031", var_132_6)
						arg_129_1:RecordAudio("320271031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320271", "320271031", "story_v_out_320271.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320271", "320271031", "story_v_out_320271.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320271032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320271032
		arg_133_1.duration_ = 9.83

		local var_133_0 = {
			zh = 7.2,
			ja = 9.833
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320271033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(320271032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 39 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 39)

				if (39 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 39)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271032", "story_v_out_320271.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271032", "story_v_out_320271.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_320271", "320271032", "story_v_out_320271.awb")

						arg_133_1:RecordAudio("320271032", var_136_6)
						arg_133_1:RecordAudio("320271032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320271", "320271032", "story_v_out_320271.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320271", "320271032", "story_v_out_320271.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320271033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320271033
		arg_137_1.duration_ = 14.13

		local var_137_0 = {
			zh = 9.366,
			ja = 14.133
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320271034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.125

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(320271033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 45 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 45)

				if (45 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 45)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271033", "story_v_out_320271.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271033", "story_v_out_320271.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320271", "320271033", "story_v_out_320271.awb")

						arg_137_1:RecordAudio("320271033", var_140_6)
						arg_137_1:RecordAudio("320271033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320271", "320271033", "story_v_out_320271.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320271", "320271033", "story_v_out_320271.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320271034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320271034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play320271035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.925

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(320271034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 37 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 37)

				if (37 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 37)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320271035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320271035
		arg_145_1.duration_ = 5.7

		local var_145_0 = {
			zh = 5.133,
			ja = 5.7
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320271036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.625

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(320271035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 25 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 25)

				if (25 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 25)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271035", "story_v_out_320271.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271035", "story_v_out_320271.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_320271", "320271035", "story_v_out_320271.awb")

						arg_145_1:RecordAudio("320271035", var_148_6)
						arg_145_1:RecordAudio("320271035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320271", "320271035", "story_v_out_320271.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320271", "320271035", "story_v_out_320271.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320271036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320271036
		arg_149_1.duration_ = 5.63

		local var_149_0 = {
			zh = 5.633,
			ja = 4.466
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320271037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.65

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(320271036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 26 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 26)

				if (26 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 26)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271036", "story_v_out_320271.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271036", "story_v_out_320271.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_320271", "320271036", "story_v_out_320271.awb")

						arg_149_1:RecordAudio("320271036", var_152_6)
						arg_149_1:RecordAudio("320271036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320271", "320271036", "story_v_out_320271.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320271", "320271036", "story_v_out_320271.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320271037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320271037
		arg_153_1.duration_ = 8.07

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play320271038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.bgs_.L07k == nil then
				local var_156_0 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07k")
				var_156_0.name = "L07k"
				var_156_0.transform.parent = arg_153_1.stage_.transform
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_.L07k = var_156_0
			end

			if 1.53333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 1.53333333333333 + arg_156_0 then
				local var_156_1 = arg_153_1.bgs_.L07k

				arg_153_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_156_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_2 = var_156_1:GetComponent("SpriteRenderer")

				if var_156_2 and var_156_2.sprite then
					local var_156_3 = 2 * (var_156_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_156_1.transform.localScale = Vector3.New(var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "L07k" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_4 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_4 + 0.3 and arg_153_1.time_ < var_156_4 + 0.3 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_5 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_6 = 1.53333333333333

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = Color.New(0, 0, 0)

				var_156_7.a = Mathf.Lerp(0, 1, (arg_153_1.time_ - var_156_5) / var_156_6)
				arg_153_1.mask_.color = var_156_7
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				local var_156_8 = Color.New(0, 0, 0)

				var_156_8.a = 1
				arg_153_1.mask_.color = var_156_8
			end

			local var_156_9 = 1.53333333333333

			if 1.53333333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_10 = 1.53333333333333

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 then
				local var_156_11 = Color.New(0, 0, 0)

				var_156_11.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_9) / var_156_10)
				arg_153_1.mask_.color = var_156_11
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 then
				local var_156_12 = Color.New(0, 0, 0)

				arg_153_1.mask_.enabled = false
				var_156_12.a = 0
				arg_153_1.mask_.color = var_156_12
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_156_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_153_1.bgmTxt_.text ~= var_156_15 and arg_153_1.bgmTxt_.text ~= "" then
						if arg_153_1.bgmTxt2_.text ~= "" then
							arg_153_1.bgmTxt_.text = arg_153_1.bgmTxt2_.text
						end

						arg_153_1.bgmTxt2_.text = var_156_15

						arg_153_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_153_1.bgmTxt_.text = var_156_15
						arg_153_1.bgmTxt2_.text = var_156_15
					end

					if arg_153_1.bgmTimer then
						arg_153_1.bgmTimer:Stop()

						arg_153_1.bgmTimer = nil
					end

					if arg_153_1.settingData.show_music_name == 1 then
						arg_153_1.musicController:SetSelectedState("show")
						arg_153_1.musicAnimator_:Play("open", 0, 0)

						if arg_153_1.settingData.music_time ~= 0 then
							arg_153_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_153_1.settingData.music_time), function()
								if arg_153_1 == nil or isNil(arg_153_1.bgmTxt_) then
									return
								end

								arg_153_1.musicController:SetSelectedState("hide")
								arg_153_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.333333333333333 + arg_156_0 then
				arg_153_1:AudioAction("play", "music", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_156_18 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

				if "" ~= "" then
					if arg_153_1.bgmTxt_.text ~= var_156_18 and arg_153_1.bgmTxt_.text ~= "" then
						if arg_153_1.bgmTxt2_.text ~= "" then
							arg_153_1.bgmTxt_.text = arg_153_1.bgmTxt2_.text
						end

						arg_153_1.bgmTxt2_.text = var_156_18

						arg_153_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_153_1.bgmTxt_.text = var_156_18
						arg_153_1.bgmTxt2_.text = var_156_18
					end

					if arg_153_1.bgmTimer then
						arg_153_1.bgmTimer:Stop()

						arg_153_1.bgmTimer = nil
					end

					if arg_153_1.settingData.show_music_name == 1 then
						arg_153_1.musicController:SetSelectedState("show")
						arg_153_1.musicAnimator_:Play("open", 0, 0)

						if arg_153_1.settingData.music_time ~= 0 then
							arg_153_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_153_1.settingData.music_time), function()
								if arg_153_1 == nil or isNil(arg_153_1.bgmTxt_) then
									return
								end

								arg_153_1.musicController:SetSelectedState("hide")
								arg_153_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_19 = 3.06666666666667
			local var_156_20 = 1.15

			if 3.06666666666667 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_21 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_21:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_153_1.dialogCg_.alpha = arg_159_0
				end))
				var_156_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_22 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(320271037).content)

				arg_153_1.text_.text = var_156_22

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_24 = 46 <= 0 and var_156_20 or var_156_20 * (utf8.len(var_156_22) / 46)

				if (46 <= 0 and var_156_20 or var_156_20 * (utf8.len(var_156_22) / 46)) > 0 and var_156_20 < var_156_24 then
					arg_153_1.talkMaxDuration = var_156_24
					var_156_19 = var_156_19 + 0.3

					if var_156_24 + var_156_19 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_19
					end
				end

				arg_153_1.text_.text = var_156_22
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = var_156_19 + 0.3
			local var_156_26 = math.max(var_156_20, arg_153_1.talkMaxDuration)

			if var_156_19 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_25 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_25) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_25 + var_156_26 and arg_153_1.time_ < var_156_25 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320271038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320271038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play320271039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.575

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(320271038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 63 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 63)

				if (63 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 63)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320271039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320271039
		arg_165_1.duration_ = 8.2

		local var_165_0 = {
			zh = 5.933,
			ja = 8.2
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320271040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.75

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(320271039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 30 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 30)

				if (30 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 30)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271039", "story_v_out_320271.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271039", "story_v_out_320271.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_320271", "320271039", "story_v_out_320271.awb")

						arg_165_1:RecordAudio("320271039", var_168_6)
						arg_165_1:RecordAudio("320271039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320271", "320271039", "story_v_out_320271.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320271", "320271039", "story_v_out_320271.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play320271040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320271040
		arg_169_1.duration_ = 5.73

		local var_169_0 = {
			zh = 5.133,
			ja = 5.733
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play320271041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.55

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(320271040)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 22)

				if (22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 22)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271040", "story_v_out_320271.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271040", "story_v_out_320271.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_320271", "320271040", "story_v_out_320271.awb")

						arg_169_1:RecordAudio("320271040", var_172_6)
						arg_169_1:RecordAudio("320271040", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320271", "320271040", "story_v_out_320271.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320271", "320271040", "story_v_out_320271.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320271041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320271041
		arg_173_1.duration_ = 10.7

		local var_173_0 = {
			zh = 7.966,
			ja = 10.7
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320271042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.725

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(320271041)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 29 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 29)

				if (29 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 29)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271041", "story_v_out_320271.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271041", "story_v_out_320271.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_320271", "320271041", "story_v_out_320271.awb")

						arg_173_1:RecordAudio("320271041", var_176_6)
						arg_173_1:RecordAudio("320271041", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_320271", "320271041", "story_v_out_320271.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_320271", "320271041", "story_v_out_320271.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320271042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320271042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320271043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.775

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(320271042).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 71 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 71)

				if (71 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 71)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320271043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320271043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play320271044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(320271043).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 57 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 57)

				if (57 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 57)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320271044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320271044
		arg_185_1.duration_ = 16.03

		local var_185_0 = {
			zh = 8.2,
			ja = 16.033
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play320271045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_188_0 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_185_1.stage_.transform)

				var_188_0.name = "10101ui_story"
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["10101ui_story"] = var_188_0

				local var_188_1 = var_188_0:GetComponentInChildren(typeof(CharacterEffect))

				var_188_1.enabled = true

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end

				arg_185_1:ShowWeapon(var_188_1.transform, false)

				arg_185_1.var_["10101ui_story" .. "Animator"] = var_188_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_185_1.var_["10101ui_story" .. "Animator"].applyRootMotion = true
				arg_185_1.var_["10101ui_story" .. "LipSync"] = var_188_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_188_3 = arg_185_1.actors_["10101ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10101ui_story = var_188_3.localPosition
			end

			local var_188_4 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				var_188_3.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_185_1.time_ - 0) / var_188_4)
				var_188_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_3.position).x, (manager.ui.mainCamera.transform.position - var_188_3.position).y, (manager.ui.mainCamera.transform.position - var_188_3.position).z)
				var_188_3.localEulerAngles.z = 0
				var_188_3.localEulerAngles.x = 0
				var_188_3.localEulerAngles = var_188_3.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				var_188_3.localPosition = Vector3.New(0, -1.16, -6.01)
				var_188_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_3.position).x, (manager.ui.mainCamera.transform.position - var_188_3.position).y, (manager.ui.mainCamera.transform.position - var_188_3.position).z)
				var_188_3.localEulerAngles.z = 0
				var_188_3.localEulerAngles.x = 0
				var_188_3.localEulerAngles = var_188_3.localEulerAngles
			end

			local var_188_5 = arg_185_1.actors_["10101ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.characterEffect10101ui_story == nil then
				arg_185_1.var_.characterEffect10101ui_story = var_188_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_6 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.characterEffect10101ui_story and not isNil(var_188_5) then
					arg_185_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.characterEffect10101ui_story then
				arg_185_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_188_8 = 0
			local var_188_9 = 1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(320271044)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 40 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 40)

				if (40 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 40)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271044", "story_v_out_320271.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_320271", "320271044", "story_v_out_320271.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_320271", "320271044", "story_v_out_320271.awb")

						arg_185_1:RecordAudio("320271044", var_188_15)
						arg_185_1:RecordAudio("320271044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320271", "320271044", "story_v_out_320271.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320271", "320271044", "story_v_out_320271.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play320271045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320271045
		arg_189_1.duration_ = 11.9

		local var_189_0 = {
			zh = 11.9,
			ja = 8.033
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play320271046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) and arg_189_1.var_.characterEffect10101ui_story == nil then
				arg_189_1.var_.characterEffect10101ui_story = arg_189_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) then
				if arg_189_1.var_.characterEffect10101ui_story and not isNil(arg_189_1.actors_["10101ui_story"]) then
					arg_189_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) and arg_189_1.var_.characterEffect10101ui_story then
				arg_189_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 1.275

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(320271045)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 51 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 51)

				if (51 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 51)) > 0 and var_192_2 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271045", "story_v_out_320271.awb") ~= 0 then
					local var_192_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271045", "story_v_out_320271.awb") / 1000

					if var_192_7 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_1
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_320271", "320271045", "story_v_out_320271.awb")

						arg_189_1:RecordAudio("320271045", var_192_8)
						arg_189_1:RecordAudio("320271045", var_192_8)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320271", "320271045", "story_v_out_320271.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320271", "320271045", "story_v_out_320271.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_9 and arg_189_1.time_ < var_192_1 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play320271046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320271046
		arg_193_1.duration_ = 12.8

		local var_193_0 = {
			zh = 12.533,
			ja = 12.8
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320271047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.2

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(320271046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 48 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 48)

				if (48 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 48)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271046", "story_v_out_320271.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271046", "story_v_out_320271.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_320271", "320271046", "story_v_out_320271.awb")

						arg_193_1:RecordAudio("320271046", var_196_6)
						arg_193_1:RecordAudio("320271046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320271", "320271046", "story_v_out_320271.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320271", "320271046", "story_v_out_320271.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320271047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320271047
		arg_197_1.duration_ = 2.4

		local var_197_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play320271048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10101ui_story"]) and arg_197_1.var_.characterEffect10101ui_story == nil then
				arg_197_1.var_.characterEffect10101ui_story = arg_197_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10101ui_story"]) then
				if arg_197_1.var_.characterEffect10101ui_story and not isNil(arg_197_1.actors_["10101ui_story"]) then
					arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10101ui_story"]) and arg_197_1.var_.characterEffect10101ui_story then
				arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			local var_200_2 = 0
			local var_200_3 = 0.2

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(320271047)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 8 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 8)

				if (8 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 8)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271047", "story_v_out_320271.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271047", "story_v_out_320271.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_320271", "320271047", "story_v_out_320271.awb")

						arg_197_1:RecordAudio("320271047", var_200_9)
						arg_197_1:RecordAudio("320271047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320271", "320271047", "story_v_out_320271.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320271", "320271047", "story_v_out_320271.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play320271048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320271048
		arg_201_1.duration_ = 13.9

		local var_201_0 = {
			zh = 13.9,
			ja = 10.1
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play320271049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10101ui_story"]) and arg_201_1.var_.characterEffect10101ui_story == nil then
				arg_201_1.var_.characterEffect10101ui_story = arg_201_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10101ui_story"]) then
				if arg_201_1.var_.characterEffect10101ui_story and not isNil(arg_201_1.actors_["10101ui_story"]) then
					arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10101ui_story"]) and arg_201_1.var_.characterEffect10101ui_story then
				arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 1.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(320271048)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_6 = 59 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_4) / 59)

				if (59 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_4) / 59)) > 0 and var_204_2 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271048", "story_v_out_320271.awb") ~= 0 then
					local var_204_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271048", "story_v_out_320271.awb") / 1000

					if var_204_7 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_1
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_320271", "320271048", "story_v_out_320271.awb")

						arg_201_1:RecordAudio("320271048", var_204_8)
						arg_201_1:RecordAudio("320271048", var_204_8)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320271", "320271048", "story_v_out_320271.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320271", "320271048", "story_v_out_320271.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_9 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_9 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_9

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_9 and arg_201_1.time_ < var_204_1 + var_204_9 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play320271049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320271049
		arg_205_1.duration_ = 14.03

		local var_205_0 = {
			zh = 11.6,
			ja = 14.033
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play320271050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(320271049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 44 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 44)

				if (44 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 44)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271049", "story_v_out_320271.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271049", "story_v_out_320271.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_320271", "320271049", "story_v_out_320271.awb")

						arg_205_1:RecordAudio("320271049", var_208_6)
						arg_205_1:RecordAudio("320271049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320271", "320271049", "story_v_out_320271.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320271", "320271049", "story_v_out_320271.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play320271050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320271050
		arg_209_1.duration_ = 7.3

		local var_209_0 = {
			zh = 6.9,
			ja = 7.3
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play320271051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10101ui_story"]) and arg_209_1.var_.characterEffect10101ui_story == nil then
				arg_209_1.var_.characterEffect10101ui_story = arg_209_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10101ui_story"]) then
				if arg_209_1.var_.characterEffect10101ui_story and not isNil(arg_209_1.actors_["10101ui_story"]) then
					arg_209_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10101ui_story"]) and arg_209_1.var_.characterEffect10101ui_story then
				arg_209_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_212_2 = 0
			local var_212_3 = 0.85

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(320271050)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 34 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 34)

				if (34 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 34)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271050", "story_v_out_320271.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271050", "story_v_out_320271.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_320271", "320271050", "story_v_out_320271.awb")

						arg_209_1:RecordAudio("320271050", var_212_9)
						arg_209_1:RecordAudio("320271050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320271", "320271050", "story_v_out_320271.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320271", "320271050", "story_v_out_320271.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play320271051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320271051
		arg_213_1.duration_ = 6.23

		local var_213_0 = {
			zh = 4.866,
			ja = 6.233
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play320271052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) and arg_213_1.var_.characterEffect10101ui_story == nil then
				arg_213_1.var_.characterEffect10101ui_story = arg_213_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) then
				if arg_213_1.var_.characterEffect10101ui_story and not isNil(arg_213_1.actors_["10101ui_story"]) then
					arg_213_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) and arg_213_1.var_.characterEffect10101ui_story then
				arg_213_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.4

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(320271051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 16 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 16)

				if (16 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 16)) > 0 and var_216_2 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271051", "story_v_out_320271.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271051", "story_v_out_320271.awb") / 1000

					if var_216_7 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_1
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_320271", "320271051", "story_v_out_320271.awb")

						arg_213_1:RecordAudio("320271051", var_216_8)
						arg_213_1:RecordAudio("320271051", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320271", "320271051", "story_v_out_320271.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320271", "320271051", "story_v_out_320271.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_9 and arg_213_1.time_ < var_216_1 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320271052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320271052
		arg_217_1.duration_ = 3.4

		local var_217_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320271053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_220_0 = arg_217_1.actors_["10101ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10101ui_story == nil then
				arg_217_1.var_.characterEffect10101ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_1 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 and not isNil(var_220_0) then
				if arg_217_1.var_.characterEffect10101ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10101ui_story then
				arg_217_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_220_3 = 0
			local var_220_4 = 0.225

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_5 = arg_217_1:GetWordFromCfg(320271052)
				local var_220_6 = arg_217_1:FormatText(var_220_5.content)

				arg_217_1.text_.text = var_220_6

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_8 = 9 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 9)

				if (9 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 9)) > 0 and var_220_4 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_6
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271052", "story_v_out_320271.awb") ~= 0 then
					local var_220_9 = manager.audio:GetVoiceLength("story_v_out_320271", "320271052", "story_v_out_320271.awb") / 1000

					if var_220_9 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_3
					end

					if var_220_5.prefab_name ~= "" and arg_217_1.actors_[var_220_5.prefab_name] ~= nil then
						local var_220_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_5.prefab_name].transform, "story_v_out_320271", "320271052", "story_v_out_320271.awb")

						arg_217_1:RecordAudio("320271052", var_220_10)
						arg_217_1:RecordAudio("320271052", var_220_10)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320271", "320271052", "story_v_out_320271.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320271", "320271052", "story_v_out_320271.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_11 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_11 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_11

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_11 and arg_217_1.time_ < var_220_3 + var_220_11 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play320271053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320271053
		arg_221_1.duration_ = 3.77

		local var_221_0 = {
			zh = 2.433,
			ja = 3.766
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play320271054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) and arg_221_1.var_.characterEffect10101ui_story == nil then
				arg_221_1.var_.characterEffect10101ui_story = arg_221_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) then
				if arg_221_1.var_.characterEffect10101ui_story and not isNil(arg_221_1.actors_["10101ui_story"]) then
					arg_221_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) and arg_221_1.var_.characterEffect10101ui_story then
				arg_221_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.225

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(320271053)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 9 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 9)

				if (9 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 9)) > 0 and var_224_2 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271053", "story_v_out_320271.awb") ~= 0 then
					local var_224_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271053", "story_v_out_320271.awb") / 1000

					if var_224_7 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_1
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_320271", "320271053", "story_v_out_320271.awb")

						arg_221_1:RecordAudio("320271053", var_224_8)
						arg_221_1:RecordAudio("320271053", var_224_8)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320271", "320271053", "story_v_out_320271.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320271", "320271053", "story_v_out_320271.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_9 and arg_221_1.time_ < var_224_1 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320271054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320271054
		arg_225_1.duration_ = 14.17

		local var_225_0 = {
			zh = 13.466,
			ja = 14.166
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play320271055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(320271054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 57 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 57)

				if (57 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 57)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271054", "story_v_out_320271.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271054", "story_v_out_320271.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_320271", "320271054", "story_v_out_320271.awb")

						arg_225_1:RecordAudio("320271054", var_228_6)
						arg_225_1:RecordAudio("320271054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320271", "320271054", "story_v_out_320271.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320271", "320271054", "story_v_out_320271.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320271055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320271055
		arg_229_1.duration_ = 14.23

		local var_229_0 = {
			zh = 12.133,
			ja = 14.233
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320271056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.275

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(320271055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 51 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 51)

				if (51 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 51)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271055", "story_v_out_320271.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271055", "story_v_out_320271.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_320271", "320271055", "story_v_out_320271.awb")

						arg_229_1:RecordAudio("320271055", var_232_6)
						arg_229_1:RecordAudio("320271055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320271", "320271055", "story_v_out_320271.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320271", "320271055", "story_v_out_320271.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320271056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320271056
		arg_233_1.duration_ = 13

		local var_233_0 = {
			zh = 10.7,
			ja = 13
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320271057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.05

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:GetWordFromCfg(320271056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 42 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 42)

				if (42 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 42)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271056", "story_v_out_320271.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271056", "story_v_out_320271.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_320271", "320271056", "story_v_out_320271.awb")

						arg_233_1:RecordAudio("320271056", var_236_6)
						arg_233_1:RecordAudio("320271056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320271", "320271056", "story_v_out_320271.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320271", "320271056", "story_v_out_320271.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320271057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320271057
		arg_237_1.duration_ = 10.87

		local var_237_0 = {
			zh = 10.866,
			ja = 10.4
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320271058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) and arg_237_1.var_.characterEffect10101ui_story == nil then
				arg_237_1.var_.characterEffect10101ui_story = arg_237_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) then
				if arg_237_1.var_.characterEffect10101ui_story and not isNil(arg_237_1.actors_["10101ui_story"]) then
					arg_237_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) and arg_237_1.var_.characterEffect10101ui_story then
				arg_237_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_240_2 = 0
			local var_240_3 = 1.325

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(320271057)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 53 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 53)

				if (53 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 53)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271057", "story_v_out_320271.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271057", "story_v_out_320271.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_320271", "320271057", "story_v_out_320271.awb")

						arg_237_1:RecordAudio("320271057", var_240_9)
						arg_237_1:RecordAudio("320271057", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320271", "320271057", "story_v_out_320271.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320271", "320271057", "story_v_out_320271.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_10 and arg_237_1.time_ < var_240_2 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320271058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320271058
		arg_241_1.duration_ = 16.5

		local var_241_0 = {
			zh = 14.933,
			ja = 16.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320271059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10101ui_story"]) and arg_241_1.var_.characterEffect10101ui_story == nil then
				arg_241_1.var_.characterEffect10101ui_story = arg_241_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10101ui_story"]) then
				if arg_241_1.var_.characterEffect10101ui_story and not isNil(arg_241_1.actors_["10101ui_story"]) then
					arg_241_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10101ui_story"]) and arg_241_1.var_.characterEffect10101ui_story then
				arg_241_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 1.475

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(320271058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 59 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 59)

				if (59 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 59)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271058", "story_v_out_320271.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271058", "story_v_out_320271.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_320271", "320271058", "story_v_out_320271.awb")

						arg_241_1:RecordAudio("320271058", var_244_8)
						arg_241_1:RecordAudio("320271058", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_320271", "320271058", "story_v_out_320271.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_320271", "320271058", "story_v_out_320271.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play320271059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320271059
		arg_245_1.duration_ = 7.73

		local var_245_0 = {
			zh = 7.733,
			ja = 7.233
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320271060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10101ui_story"]) and arg_245_1.var_.characterEffect10101ui_story == nil then
				arg_245_1.var_.characterEffect10101ui_story = arg_245_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10101ui_story"]) then
				if arg_245_1.var_.characterEffect10101ui_story and not isNil(arg_245_1.actors_["10101ui_story"]) then
					arg_245_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10101ui_story"]) and arg_245_1.var_.characterEffect10101ui_story then
				arg_245_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_248_2 = 0
			local var_248_3 = 0.825

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(320271059)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 33 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 33)

				if (33 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 33)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271059", "story_v_out_320271.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271059", "story_v_out_320271.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_out_320271", "320271059", "story_v_out_320271.awb")

						arg_245_1:RecordAudio("320271059", var_248_9)
						arg_245_1:RecordAudio("320271059", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320271", "320271059", "story_v_out_320271.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320271", "320271059", "story_v_out_320271.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320271060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320271060
		arg_249_1.duration_ = 7.47

		local var_249_0 = {
			zh = 3.933,
			ja = 7.466
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320271061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10101ui_story"]) and arg_249_1.var_.characterEffect10101ui_story == nil then
				arg_249_1.var_.characterEffect10101ui_story = arg_249_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10101ui_story"]) then
				if arg_249_1.var_.characterEffect10101ui_story and not isNil(arg_249_1.actors_["10101ui_story"]) then
					arg_249_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10101ui_story"]) and arg_249_1.var_.characterEffect10101ui_story then
				arg_249_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.375

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(320271060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 15 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 15)

				if (15 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 15)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271060", "story_v_out_320271.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271060", "story_v_out_320271.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_320271", "320271060", "story_v_out_320271.awb")

						arg_249_1:RecordAudio("320271060", var_252_8)
						arg_249_1:RecordAudio("320271060", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320271", "320271060", "story_v_out_320271.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320271", "320271060", "story_v_out_320271.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play320271061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320271061
		arg_253_1.duration_ = 9.63

		local var_253_0 = {
			zh = 9.633,
			ja = 4.966
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320271062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(320271061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 40 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 40)

				if (40 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 40)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271061", "story_v_out_320271.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271061", "story_v_out_320271.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_320271", "320271061", "story_v_out_320271.awb")

						arg_253_1:RecordAudio("320271061", var_256_6)
						arg_253_1:RecordAudio("320271061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_320271", "320271061", "story_v_out_320271.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_320271", "320271061", "story_v_out_320271.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play320271062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320271062
		arg_257_1.duration_ = 10.1

		local var_257_0 = {
			zh = 10.1,
			ja = 9.966
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320271063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.9

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(320271062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 36)

				if (36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 36)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271062", "story_v_out_320271.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271062", "story_v_out_320271.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_320271", "320271062", "story_v_out_320271.awb")

						arg_257_1:RecordAudio("320271062", var_260_6)
						arg_257_1:RecordAudio("320271062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320271", "320271062", "story_v_out_320271.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320271", "320271062", "story_v_out_320271.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320271063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320271063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play320271064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_264_0 = 0
			local var_264_1 = 1.45

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_2 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(320271063).content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 58 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_2) / 58)

				if (58 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_2) / 58)) > 0 and var_264_1 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_5 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_5 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_5

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_5 and arg_261_1.time_ < var_264_0 + var_264_5 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320271064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320271064
		arg_265_1.duration_ = 5.17

		local var_265_0 = {
			zh = 5.166,
			ja = 4.4
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320271065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10101ui_story"]) and arg_265_1.var_.characterEffect10101ui_story == nil then
				arg_265_1.var_.characterEffect10101ui_story = arg_265_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10101ui_story"]) then
				if arg_265_1.var_.characterEffect10101ui_story and not isNil(arg_265_1.actors_["10101ui_story"]) then
					arg_265_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10101ui_story"]) and arg_265_1.var_.characterEffect10101ui_story then
				arg_265_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_268_2 = 0
			local var_268_3 = 0.425

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(320271064)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 17 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 17)

				if (17 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 17)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271064", "story_v_out_320271.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271064", "story_v_out_320271.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_320271", "320271064", "story_v_out_320271.awb")

						arg_265_1:RecordAudio("320271064", var_268_9)
						arg_265_1:RecordAudio("320271064", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320271", "320271064", "story_v_out_320271.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320271", "320271064", "story_v_out_320271.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320271065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320271065
		arg_269_1.duration_ = 3.7

		local var_269_0 = {
			zh = 2.6,
			ja = 3.7
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320271066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["10101ui_story"]) and arg_269_1.var_.characterEffect10101ui_story == nil then
				arg_269_1.var_.characterEffect10101ui_story = arg_269_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["10101ui_story"]) then
				if arg_269_1.var_.characterEffect10101ui_story and not isNil(arg_269_1.actors_["10101ui_story"]) then
					arg_269_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["10101ui_story"]) and arg_269_1.var_.characterEffect10101ui_story then
				arg_269_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.275

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(320271065)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_6 = 11 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_4) / 11)

				if (11 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_4) / 11)) > 0 and var_272_2 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271065", "story_v_out_320271.awb") ~= 0 then
					local var_272_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271065", "story_v_out_320271.awb") / 1000

					if var_272_7 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_1
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_320271", "320271065", "story_v_out_320271.awb")

						arg_269_1:RecordAudio("320271065", var_272_8)
						arg_269_1:RecordAudio("320271065", var_272_8)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320271", "320271065", "story_v_out_320271.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320271", "320271065", "story_v_out_320271.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_9 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_9 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_9

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_9 and arg_269_1.time_ < var_272_1 + var_272_9 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320271066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320271066
		arg_273_1.duration_ = 8.47

		local var_273_0 = {
			zh = 8.466,
			ja = 7.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320271067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10101ui_story = arg_273_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).z)
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles = arg_273_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_273_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10101ui_story"].transform.position).z)
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10101ui_story"].transform.localEulerAngles = arg_273_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10101ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10101ui_story == nil then
				arg_273_1.var_.characterEffect10101ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10101ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10101ui_story then
				arg_273_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action452")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.85

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(320271066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 34 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 34)

				if (34 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 34)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271066", "story_v_out_320271.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_320271", "320271066", "story_v_out_320271.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_320271", "320271066", "story_v_out_320271.awb")

						arg_273_1:RecordAudio("320271066", var_276_11)
						arg_273_1:RecordAudio("320271066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_320271", "320271066", "story_v_out_320271.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_320271", "320271066", "story_v_out_320271.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play320271067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320271067
		arg_277_1.duration_ = 13.37

		local var_277_0 = {
			zh = 10.033,
			ja = 13.366
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320271068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_280_0 = 0
			local var_280_1 = 1.15

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(320271067)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 46 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 46)

				if (46 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 46)) > 0 and var_280_1 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271067", "story_v_out_320271.awb") ~= 0 then
					local var_280_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271067", "story_v_out_320271.awb") / 1000

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end

					if var_280_2.prefab_name ~= "" and arg_277_1.actors_[var_280_2.prefab_name] ~= nil then
						local var_280_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_2.prefab_name].transform, "story_v_out_320271", "320271067", "story_v_out_320271.awb")

						arg_277_1:RecordAudio("320271067", var_280_7)
						arg_277_1:RecordAudio("320271067", var_280_7)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_320271", "320271067", "story_v_out_320271.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_320271", "320271067", "story_v_out_320271.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320271068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320271068
		arg_281_1.duration_ = 14.3

		local var_281_0 = {
			zh = 10.9,
			ja = 14.3
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320271069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.225

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(320271068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 49 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 49)

				if (49 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 49)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271068", "story_v_out_320271.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271068", "story_v_out_320271.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_320271", "320271068", "story_v_out_320271.awb")

						arg_281_1:RecordAudio("320271068", var_284_6)
						arg_281_1:RecordAudio("320271068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320271", "320271068", "story_v_out_320271.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320271", "320271068", "story_v_out_320271.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320271069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320271069
		arg_285_1.duration_ = 9.17

		local var_285_0 = {
			zh = 4.7,
			ja = 9.166
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play320271070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_288_0 = 0
			local var_288_1 = 0.425

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(320271069)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 17 <= 0 and var_288_1 or var_288_1 * (utf8.len(var_288_3) / 17)

				if (17 <= 0 and var_288_1 or var_288_1 * (utf8.len(var_288_3) / 17)) > 0 and var_288_1 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271069", "story_v_out_320271.awb") ~= 0 then
					local var_288_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271069", "story_v_out_320271.awb") / 1000

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end

					if var_288_2.prefab_name ~= "" and arg_285_1.actors_[var_288_2.prefab_name] ~= nil then
						local var_288_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_2.prefab_name].transform, "story_v_out_320271", "320271069", "story_v_out_320271.awb")

						arg_285_1:RecordAudio("320271069", var_288_7)
						arg_285_1:RecordAudio("320271069", var_288_7)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_320271", "320271069", "story_v_out_320271.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_320271", "320271069", "story_v_out_320271.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play320271070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 320271070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play320271071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10101ui_story"]) and arg_289_1.var_.characterEffect10101ui_story == nil then
				arg_289_1.var_.characterEffect10101ui_story = arg_289_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10101ui_story"]) then
				if arg_289_1.var_.characterEffect10101ui_story and not isNil(arg_289_1.actors_["10101ui_story"]) then
					arg_289_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10101ui_story"]) and arg_289_1.var_.characterEffect10101ui_story then
				arg_289_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 0.65

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(320271070).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 26 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 26)

				if (26 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 26)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play320271071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 320271071
		arg_293_1.duration_ = 10.63

		local var_293_0 = {
			zh = 6.9,
			ja = 10.633
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play320271072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["10101ui_story"]) and arg_293_1.var_.characterEffect10101ui_story == nil then
				arg_293_1.var_.characterEffect10101ui_story = arg_293_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["10101ui_story"]) then
				if arg_293_1.var_.characterEffect10101ui_story and not isNil(arg_293_1.actors_["10101ui_story"]) then
					arg_293_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["10101ui_story"]) and arg_293_1.var_.characterEffect10101ui_story then
				arg_293_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_296_2 = 0
			local var_296_3 = 0.85

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(320271071)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 34 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 34)

				if (34 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 34)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271071", "story_v_out_320271.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271071", "story_v_out_320271.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_320271", "320271071", "story_v_out_320271.awb")

						arg_293_1:RecordAudio("320271071", var_296_9)
						arg_293_1:RecordAudio("320271071", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_320271", "320271071", "story_v_out_320271.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_320271", "320271071", "story_v_out_320271.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play320271072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320271072
		arg_297_1.duration_ = 16.47

		local var_297_0 = {
			zh = 14.9,
			ja = 16.466
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play320271073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_300_0 = 0
			local var_300_1 = 1.55

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(320271072)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 62 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 62)

				if (62 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 62)) > 0 and var_300_1 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271072", "story_v_out_320271.awb") ~= 0 then
					local var_300_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271072", "story_v_out_320271.awb") / 1000

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end

					if var_300_2.prefab_name ~= "" and arg_297_1.actors_[var_300_2.prefab_name] ~= nil then
						local var_300_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_2.prefab_name].transform, "story_v_out_320271", "320271072", "story_v_out_320271.awb")

						arg_297_1:RecordAudio("320271072", var_300_7)
						arg_297_1:RecordAudio("320271072", var_300_7)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_320271", "320271072", "story_v_out_320271.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_320271", "320271072", "story_v_out_320271.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320271073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 320271073
		arg_301_1.duration_ = 6.6

		local var_301_0 = {
			zh = 6.6,
			ja = 5.233
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play320271074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["10101ui_story"]) and arg_301_1.var_.characterEffect10101ui_story == nil then
				arg_301_1.var_.characterEffect10101ui_story = arg_301_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["10101ui_story"]) then
				if arg_301_1.var_.characterEffect10101ui_story and not isNil(arg_301_1.actors_["10101ui_story"]) then
					arg_301_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["10101ui_story"]) and arg_301_1.var_.characterEffect10101ui_story then
				arg_301_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_304_1 = 0
			local var_304_2 = 0.625

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(320271073)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 25 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_4) / 25)

				if (25 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_4) / 25)) > 0 and var_304_2 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271073", "story_v_out_320271.awb") ~= 0 then
					local var_304_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271073", "story_v_out_320271.awb") / 1000

					if var_304_7 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_1
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_320271", "320271073", "story_v_out_320271.awb")

						arg_301_1:RecordAudio("320271073", var_304_8)
						arg_301_1:RecordAudio("320271073", var_304_8)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_320271", "320271073", "story_v_out_320271.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_320271", "320271073", "story_v_out_320271.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_9 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_9 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_9

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_9 and arg_301_1.time_ < var_304_1 + var_304_9 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play320271074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 320271074
		arg_305_1.duration_ = 9.3

		local var_305_0 = {
			zh = 9.3,
			ja = 7.9
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play320271075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10101ui_story"]) and arg_305_1.var_.characterEffect10101ui_story == nil then
				arg_305_1.var_.characterEffect10101ui_story = arg_305_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10101ui_story"]) then
				if arg_305_1.var_.characterEffect10101ui_story and not isNil(arg_305_1.actors_["10101ui_story"]) then
					arg_305_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10101ui_story"]) and arg_305_1.var_.characterEffect10101ui_story then
				arg_305_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_308_2 = 0
			local var_308_3 = 0.75

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_4 = arg_305_1:GetWordFromCfg(320271074)
				local var_308_5 = arg_305_1:FormatText(var_308_4.content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 30 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_5) / 30)

				if (30 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_5) / 30)) > 0 and var_308_3 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271074", "story_v_out_320271.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271074", "story_v_out_320271.awb") / 1000

					if var_308_8 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_2
					end

					if var_308_4.prefab_name ~= "" and arg_305_1.actors_[var_308_4.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_4.prefab_name].transform, "story_v_out_320271", "320271074", "story_v_out_320271.awb")

						arg_305_1:RecordAudio("320271074", var_308_9)
						arg_305_1:RecordAudio("320271074", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_320271", "320271074", "story_v_out_320271.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_320271", "320271074", "story_v_out_320271.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_10 and arg_305_1.time_ < var_308_2 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play320271075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 320271075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play320271076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10101ui_story = arg_309_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).z)
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles = arg_309_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10101ui_story"].transform.position).z)
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10101ui_story"].transform.localEulerAngles = arg_309_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["10101ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect10101ui_story == nil then
				arg_309_1.var_.characterEffect10101ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect10101ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_2)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect10101ui_story then
				arg_309_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_312_3 = 0
			local var_312_4 = 1.475

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(320271075).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 59 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 59)

				if (59 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 59)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play320271076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320271076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play320271077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 1.075

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(320271076).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 43 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 43)

				if (43 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 43)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320271077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320271077
		arg_317_1.duration_ = 16.23

		local var_317_0 = {
			zh = 16.233,
			ja = 11.7
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320271078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.575

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:GetWordFromCfg(320271077)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 62 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 62)

				if (62 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 62)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271077", "story_v_out_320271.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271077", "story_v_out_320271.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_320271", "320271077", "story_v_out_320271.awb")

						arg_317_1:RecordAudio("320271077", var_320_6)
						arg_317_1:RecordAudio("320271077", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_320271", "320271077", "story_v_out_320271.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_320271", "320271077", "story_v_out_320271.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320271078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320271078
		arg_321_1.duration_ = 6

		local var_321_0 = {
			zh = 6,
			ja = 5.266
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play320271079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10101ui_story = arg_321_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).z)
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles = arg_321_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_321_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10101ui_story"].transform.position).z)
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10101ui_story"].transform.localEulerAngles = arg_321_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["10101ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10101ui_story == nil then
				arg_321_1.var_.characterEffect10101ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect10101ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10101ui_story then
				arg_321_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_4 = 0.6
			local var_324_5 = 0.575

			if 0.6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_6 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_6:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(320271078)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 23 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_8) / 23)

				if (23 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_8) / 23)) > 0 and var_324_5 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10
					var_324_4 = var_324_4 + 0.3

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271078", "story_v_out_320271.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_320271", "320271078", "story_v_out_320271.awb") / 1000

					if var_324_11 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_4
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_320271", "320271078", "story_v_out_320271.awb")

						arg_321_1:RecordAudio("320271078", var_324_12)
						arg_321_1:RecordAudio("320271078", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_320271", "320271078", "story_v_out_320271.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_320271", "320271078", "story_v_out_320271.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = var_324_4 + 0.3
			local var_324_14 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_13 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_13) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_13 + var_324_14 and arg_321_1.time_ < var_324_13 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play320271079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 320271079
		arg_327_1.duration_ = 8.63

		local var_327_0 = {
			zh = 8.366,
			ja = 8.633
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play320271080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10101ui_story"]) and arg_327_1.var_.characterEffect10101ui_story == nil then
				arg_327_1.var_.characterEffect10101ui_story = arg_327_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10101ui_story"]) then
				if arg_327_1.var_.characterEffect10101ui_story and not isNil(arg_327_1.actors_["10101ui_story"]) then
					arg_327_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_327_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10101ui_story"]) and arg_327_1.var_.characterEffect10101ui_story then
				arg_327_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_327_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.7

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(320271079)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 28 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 28)

				if (28 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 28)) > 0 and var_330_2 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271079", "story_v_out_320271.awb") ~= 0 then
					local var_330_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271079", "story_v_out_320271.awb") / 1000

					if var_330_7 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_1
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_320271", "320271079", "story_v_out_320271.awb")

						arg_327_1:RecordAudio("320271079", var_330_8)
						arg_327_1:RecordAudio("320271079", var_330_8)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_320271", "320271079", "story_v_out_320271.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_320271", "320271079", "story_v_out_320271.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_9 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_9 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_9

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_9 and arg_327_1.time_ < var_330_1 + var_330_9 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play320271080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 320271080
		arg_331_1.duration_ = 13.33

		local var_331_0 = {
			zh = 9.8,
			ja = 13.333
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play320271081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.15

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:GetWordFromCfg(320271080)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 46 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 46)

				if (46 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 46)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271080", "story_v_out_320271.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271080", "story_v_out_320271.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_320271", "320271080", "story_v_out_320271.awb")

						arg_331_1:RecordAudio("320271080", var_334_6)
						arg_331_1:RecordAudio("320271080", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_320271", "320271080", "story_v_out_320271.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_320271", "320271080", "story_v_out_320271.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play320271081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 320271081
		arg_335_1.duration_ = 12.27

		local var_335_0 = {
			zh = 11.933,
			ja = 12.266
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play320271082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.075

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:GetWordFromCfg(320271081)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 43 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 43)

				if (43 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 43)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271081", "story_v_out_320271.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271081", "story_v_out_320271.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_320271", "320271081", "story_v_out_320271.awb")

						arg_335_1:RecordAudio("320271081", var_338_6)
						arg_335_1:RecordAudio("320271081", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_320271", "320271081", "story_v_out_320271.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_320271", "320271081", "story_v_out_320271.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play320271082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 320271082
		arg_339_1.duration_ = 6.53

		local var_339_0 = {
			zh = 4.833,
			ja = 6.533
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play320271083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10101ui_story"]) and arg_339_1.var_.characterEffect10101ui_story == nil then
				arg_339_1.var_.characterEffect10101ui_story = arg_339_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10101ui_story"]) then
				if arg_339_1.var_.characterEffect10101ui_story and not isNil(arg_339_1.actors_["10101ui_story"]) then
					arg_339_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10101ui_story"]) and arg_339_1.var_.characterEffect10101ui_story then
				arg_339_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_342_2 = 0
			local var_342_3 = 0.525

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_4 = arg_339_1:GetWordFromCfg(320271082)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 21 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 21)

				if (21 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 21)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271082", "story_v_out_320271.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271082", "story_v_out_320271.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_out_320271", "320271082", "story_v_out_320271.awb")

						arg_339_1:RecordAudio("320271082", var_342_9)
						arg_339_1:RecordAudio("320271082", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_320271", "320271082", "story_v_out_320271.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_320271", "320271082", "story_v_out_320271.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play320271083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 320271083
		arg_343_1.duration_ = 8.1

		local var_343_0 = {
			zh = 6.9,
			ja = 8.1
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play320271084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10101ui_story"]) and arg_343_1.var_.characterEffect10101ui_story == nil then
				arg_343_1.var_.characterEffect10101ui_story = arg_343_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10101ui_story"]) then
				if arg_343_1.var_.characterEffect10101ui_story and not isNil(arg_343_1.actors_["10101ui_story"]) then
					arg_343_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_343_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10101ui_story"]) and arg_343_1.var_.characterEffect10101ui_story then
				arg_343_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_343_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.65

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(320271083)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 26 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 26)

				if (26 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 26)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271083", "story_v_out_320271.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271083", "story_v_out_320271.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_320271", "320271083", "story_v_out_320271.awb")

						arg_343_1:RecordAudio("320271083", var_346_8)
						arg_343_1:RecordAudio("320271083", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_320271", "320271083", "story_v_out_320271.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_320271", "320271083", "story_v_out_320271.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play320271084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320271084
		arg_347_1.duration_ = 6.6

		local var_347_0 = {
			zh = 3.466,
			ja = 6.6
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play320271085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10101ui_story"]) and arg_347_1.var_.characterEffect10101ui_story == nil then
				arg_347_1.var_.characterEffect10101ui_story = arg_347_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10101ui_story"]) then
				if arg_347_1.var_.characterEffect10101ui_story and not isNil(arg_347_1.actors_["10101ui_story"]) then
					arg_347_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10101ui_story"]) and arg_347_1.var_.characterEffect10101ui_story then
				arg_347_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_350_2 = 0
			local var_350_3 = 0.425

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(320271084)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 17 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 17)

				if (17 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 17)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271084", "story_v_out_320271.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271084", "story_v_out_320271.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_320271", "320271084", "story_v_out_320271.awb")

						arg_347_1:RecordAudio("320271084", var_350_9)
						arg_347_1:RecordAudio("320271084", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320271", "320271084", "story_v_out_320271.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320271", "320271084", "story_v_out_320271.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play320271085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320271085
		arg_351_1.duration_ = 8.27

		local var_351_0 = {
			zh = 6.3,
			ja = 8.266
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play320271086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10101ui_story"]) and arg_351_1.var_.characterEffect10101ui_story == nil then
				arg_351_1.var_.characterEffect10101ui_story = arg_351_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10101ui_story"]) then
				if arg_351_1.var_.characterEffect10101ui_story and not isNil(arg_351_1.actors_["10101ui_story"]) then
					arg_351_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10101ui_story"]) and arg_351_1.var_.characterEffect10101ui_story then
				arg_351_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.725

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(320271085)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 29 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 29)

				if (29 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 29)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271085", "story_v_out_320271.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_320271", "320271085", "story_v_out_320271.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_320271", "320271085", "story_v_out_320271.awb")

						arg_351_1:RecordAudio("320271085", var_354_8)
						arg_351_1:RecordAudio("320271085", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320271", "320271085", "story_v_out_320271.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320271", "320271085", "story_v_out_320271.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play320271086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320271086
		arg_355_1.duration_ = 18

		local var_355_0 = {
			zh = 12.966,
			ja = 18
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320271087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.325

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(320271086)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 53 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 53)

				if (53 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 53)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271086", "story_v_out_320271.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271086", "story_v_out_320271.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_320271", "320271086", "story_v_out_320271.awb")

						arg_355_1:RecordAudio("320271086", var_358_6)
						arg_355_1:RecordAudio("320271086", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_320271", "320271086", "story_v_out_320271.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_320271", "320271086", "story_v_out_320271.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play320271087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320271087
		arg_359_1.duration_ = 9.57

		local var_359_0 = {
			zh = 5.9,
			ja = 9.566
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play320271088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10101ui_story = arg_359_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).z)
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles = arg_359_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.01)
				arg_359_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["10101ui_story"].transform.position).z)
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["10101ui_story"].transform.localEulerAngles = arg_359_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["10101ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect10101ui_story == nil then
				arg_359_1.var_.characterEffect10101ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect10101ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect10101ui_story then
				arg_359_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_362_4 = 0
			local var_362_5 = 0.475

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(320271087)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 19 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 19)

				if (19 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 19)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271087", "story_v_out_320271.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_320271", "320271087", "story_v_out_320271.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_320271", "320271087", "story_v_out_320271.awb")

						arg_359_1:RecordAudio("320271087", var_362_11)
						arg_359_1:RecordAudio("320271087", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_320271", "320271087", "story_v_out_320271.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_320271", "320271087", "story_v_out_320271.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play320271088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 320271088
		arg_363_1.duration_ = 5.67

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play320271089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10101ui_story = arg_363_1.actors_["10101ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["10101ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).z)
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles = arg_363_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["10101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_["10101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10101ui_story"].transform.position).z)
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10101ui_story"].transform.localEulerAngles = arg_363_1.actors_["10101ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["10101ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect10101ui_story == nil then
				arg_363_1.var_.characterEffect10101ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect10101ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_363_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_2)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect10101ui_story then
				arg_363_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_363_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_366_3 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = false

				arg_363_1:SetGaussion(false)
			end

			local var_366_4 = 0.466666666666667

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_4 then
				local var_366_5 = Color.New(1, 1, 1)

				var_366_5.a = Mathf.Lerp(1, 0, (arg_363_1.time_ - var_366_3) / var_366_4)
				arg_363_1.mask_.color = var_366_5
			end

			if arg_363_1.time_ >= var_366_3 + var_366_4 and arg_363_1.time_ < var_366_3 + var_366_4 + arg_366_0 then
				local var_366_6 = Color.New(1, 1, 1)

				arg_363_1.mask_.enabled = false
				var_366_6.a = 0
				arg_363_1.mask_.color = var_366_6
			end

			if arg_363_1.frameCnt_ <= 1 then
				arg_363_1.dialog_:SetActive(false)
			end

			local var_366_7 = 0.666666666666667
			local var_366_8 = 0.775

			if 0.666666666666667 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				arg_363_1.dialog_:SetActive(true)

				arg_363_1.dialogCg_.alpha = 0

				local var_366_9 = LeanTween.value(arg_363_1.dialog_, 0, 1, 0.3)

				var_366_9:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_363_1.dialogCg_.alpha = arg_367_0
				end))
				var_366_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_363_1.dialog_)
					var_366_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_363_1.duration_ = arg_363_1.duration_ + 0.3

				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(320271088).content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 31 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 31)

				if (31 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 31)) > 0 and var_366_8 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12
					var_366_7 = var_366_7 + 0.3

					if var_366_12 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_7
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = var_366_7 + 0.3
			local var_366_14 = math.max(var_366_8, arg_363_1.talkMaxDuration)

			if var_366_7 + 0.3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_13 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_13) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_13 + var_366_14 and arg_363_1.time_ < var_366_13 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play320271089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 320271089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play320271090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_372_0 = 0.533333333333333

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				local var_372_1, var_372_2 = math.modf((arg_369_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_372_2 * 0.13, var_372_2 * 0.13, var_372_2 * 0.13) + arg_369_1.var_.shakeOldPos
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				manager.ui.mainCamera.transform.localPosition = arg_369_1.var_.shakeOldPos
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fight03", "")
			end

			local var_372_4 = 0
			local var_372_5 = 1.4

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(320271089).content)

				arg_369_1.text_.text = var_372_6

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_8 = 56 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_6) / 56)

				if (56 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_6) / 56)) > 0 and var_372_5 < var_372_8 then
					arg_369_1.talkMaxDuration = var_372_8

					if var_372_8 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_6
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_9 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_9 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_9

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_9 and arg_369_1.time_ < var_372_4 + var_372_9 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play320271090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 320271090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play320271091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 1.075

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(320271090).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 43 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 43)

				if (43 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 43)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play320271091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320271091
		arg_377_1.duration_ = 3.67

		local var_377_0 = {
			zh = 1.7,
			ja = 3.666
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play320271092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.175

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:GetWordFromCfg(320271091)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 7 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 7)

				if (7 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 7)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271091", "story_v_out_320271.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271091", "story_v_out_320271.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_320271", "320271091", "story_v_out_320271.awb")

						arg_377_1:RecordAudio("320271091", var_380_6)
						arg_377_1:RecordAudio("320271091", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_320271", "320271091", "story_v_out_320271.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_320271", "320271091", "story_v_out_320271.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play320271092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 320271092
		arg_381_1.duration_ = 4.47

		local var_381_0 = {
			zh = 3.366,
			ja = 4.466
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play320271093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.35

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:GetWordFromCfg(320271092)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 14 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 14)

				if (14 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 14)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271092", "story_v_out_320271.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271092", "story_v_out_320271.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_320271", "320271092", "story_v_out_320271.awb")

						arg_381_1:RecordAudio("320271092", var_384_6)
						arg_381_1:RecordAudio("320271092", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_320271", "320271092", "story_v_out_320271.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_320271", "320271092", "story_v_out_320271.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play320271093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 320271093
		arg_385_1.duration_ = 6.13

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play320271094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_9002
			local var_388_9001
			local var_388_9000

			if 0.433333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 0.433333333333333 + arg_388_0 then
				local var_388_0 = arg_385_1.var_.effect123

				if not arg_385_1.var_.effect123 then
					var_388_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_1"), manager.ui.mainCamera.transform)
					var_388_0.name = "123"
					arg_385_1.var_.effect123 = var_388_0
				else
					var_388_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_388_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_388_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.53333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 1.53333333333333 + arg_388_0 then
				local var_388_2 = arg_385_1.var_.effect124

				if not arg_385_1.var_.effect124 then
					var_388_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_1"), manager.ui.mainCamera.transform)
					var_388_2.name = "124"
					arg_385_1.var_.effect124 = var_388_2
				else
					var_388_2.transform:SetParent(var_388_9002)
				end

				var_388_2.transform.localPosition = Vector3.New(0.04, -0.02, 0)
				var_388_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.63333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 2.63333333333333 + arg_388_0 then
				local var_388_4 = arg_385_1.var_.effect125

				if not arg_385_1.var_.effect125 then
					var_388_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_1"), manager.ui.mainCamera.transform)
					var_388_4.name = "125"
					arg_385_1.var_.effect125 = var_388_4
				else
					var_388_4.transform:SetParent(var_388_9001)
				end

				var_388_4.transform.localPosition = Vector3.New(0.06, -0.08, 0)
				var_388_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				local var_388_6 = arg_385_1.var_.effect777

				if not arg_385_1.var_.effect777 then
					var_388_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), manager.ui.mainCamera.transform)
					var_388_6.name = "777"
					arg_385_1.var_.effect777 = var_388_6
				else
					var_388_6.transform:SetParent(var_388_9000)
				end

				var_388_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_388_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_388_8 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_9 = 0.666666666666667

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 then
				local var_388_10 = Color.New(0.3301887, 0.06385724, 0.06385724)

				var_388_10.a = Mathf.Lerp(1, 0, (arg_385_1.time_ - var_388_8) / var_388_9)
				arg_385_1.mask_.color = var_388_10
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 then
				local var_388_11 = Color.New(0.3301887, 0.06385724, 0.06385724)

				arg_385_1.mask_.enabled = false
				var_388_11.a = 0
				arg_385_1.mask_.color = var_388_11
			end

			local var_388_12 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_12 + arg_388_0 then
				arg_385_1.allBtn_.enabled = false
			end

			if arg_385_1.time_ >= var_388_12 + 1.7 and arg_385_1.time_ < var_388_12 + 1.7 + arg_388_0 then
				arg_385_1.allBtn_.enabled = true
			end

			if 0.333333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 0.333333333333333 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_14 = 1.13333333333333
			local var_388_15 = 1.8

			if 1.13333333333333 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_16 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_16:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_385_1.dialogCg_.alpha = arg_389_0
				end))
				var_388_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_17 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(320271093).content)

				arg_385_1.text_.text = var_388_17

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_19 = 72 <= 0 and var_388_15 or var_388_15 * (utf8.len(var_388_17) / 72)

				if (72 <= 0 and var_388_15 or var_388_15 * (utf8.len(var_388_17) / 72)) > 0 and var_388_15 < var_388_19 then
					arg_385_1.talkMaxDuration = var_388_19
					var_388_14 = var_388_14 + 0.3

					if var_388_19 + var_388_14 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_19 + var_388_14
					end
				end

				arg_385_1.text_.text = var_388_17
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_20 = var_388_14 + 0.3
			local var_388_21 = math.max(var_388_15, arg_385_1.talkMaxDuration)

			if var_388_14 + 0.3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_20 + var_388_21 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_20) / var_388_21

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_20 + var_388_21 and arg_385_1.time_ < var_388_20 + var_388_21 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play320271094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 320271094
		arg_391_1.duration_ = 7

		local var_391_0 = {
			zh = 3.6,
			ja = 7
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play320271095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.475

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(320271094)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 19 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 19)

				if (19 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 19)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271094", "story_v_out_320271.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271094", "story_v_out_320271.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_320271", "320271094", "story_v_out_320271.awb")

						arg_391_1:RecordAudio("320271094", var_394_6)
						arg_391_1:RecordAudio("320271094", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_320271", "320271094", "story_v_out_320271.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_320271", "320271094", "story_v_out_320271.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play320271095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 320271095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play320271096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.2

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(320271095).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 48 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 48)

				if (48 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 48)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play320271096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 320271096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play320271097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 1.75

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(320271096).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 70 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 70)

				if (70 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 70)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play320271097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 320271097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play320271098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 1.175

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(320271097).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 47 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 47)

				if (47 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 47)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play320271098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 320271098
		arg_407_1.duration_ = 5.27

		local var_407_0 = {
			zh = 1.3,
			ja = 5.266
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play320271099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.1

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10101")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:GetWordFromCfg(320271098)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 4 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 4)

				if (4 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 4)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271098", "story_v_out_320271.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271098", "story_v_out_320271.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_out_320271", "320271098", "story_v_out_320271.awb")

						arg_407_1:RecordAudio("320271098", var_410_6)
						arg_407_1:RecordAudio("320271098", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_320271", "320271098", "story_v_out_320271.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_320271", "320271098", "story_v_out_320271.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play320271099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 320271099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play320271100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.825

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(320271099).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 33 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 33)

				if (33 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 33)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play320271100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 320271100
		arg_415_1.duration_ = 7.5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play320271101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_9000

			if 1.4 < arg_415_1.time_ and arg_415_1.time_ <= 1.4 + arg_418_0 then
				if arg_415_1.var_.effect123 then
					Object.Destroy(arg_415_1.var_.effect123)

					arg_415_1.var_.effect123 = nil
				end
			end

			local var_418_1 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_2 = 1.4

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_418_3.a = Mathf.Lerp(0, 1, (arg_415_1.time_ - var_418_1) / var_418_2)
				arg_415_1.mask_.color = var_418_3
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				local var_418_4 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_418_4.a = 1
				arg_415_1.mask_.color = var_418_4
			end

			local var_418_5 = 1.4

			if 1.4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_6 = 1.4

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_6 then
				local var_418_7 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_418_7.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_5) / var_418_6)
				arg_415_1.mask_.color = var_418_7
			end

			if arg_415_1.time_ >= var_418_5 + var_418_6 and arg_415_1.time_ < var_418_5 + var_418_6 + arg_418_0 then
				local var_418_8 = Color.New(0.01886791, 0.01886791, 0.01886791)

				arg_415_1.mask_.enabled = false
				var_418_8.a = 0
				arg_415_1.mask_.color = var_418_8
			end

			if 1.4 < arg_415_1.time_ and arg_415_1.time_ <= 1.4 + arg_418_0 then
				if arg_415_1.var_.effect125 then
					Object.Destroy(arg_415_1.var_.effect125)

					arg_415_1.var_.effect125 = nil
				end
			end

			if 1.4 < arg_415_1.time_ and arg_415_1.time_ <= 1.4 + arg_418_0 then
				if arg_415_1.var_.effect124 then
					Object.Destroy(arg_415_1.var_.effect124)

					arg_415_1.var_.effect124 = nil
				end
			end

			if 1.4 < arg_415_1.time_ and arg_415_1.time_ <= 1.4 + arg_418_0 then
				if arg_415_1.var_.effect777 then
					Object.Destroy(arg_415_1.var_.effect777)

					arg_415_1.var_.effect777 = nil
				end
			end

			if 1.41666666666667 < arg_415_1.time_ and arg_415_1.time_ <= 1.41666666666667 + arg_418_0 then
				local var_418_12 = arg_415_1.var_.effect999

				if not arg_415_1.var_.effect999 then
					var_418_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_418_12.name = "999"
					arg_415_1.var_.effect999 = var_418_12
				else
					var_418_12.transform:SetParent(var_418_9000)
				end

				var_418_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_418_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.2 < arg_415_1.time_ and arg_415_1.time_ <= 3.2 + arg_418_0 then
				if arg_415_1.var_.effect999 then
					Object.Destroy(arg_415_1.var_.effect999)

					arg_415_1.var_.effect999 = nil
				end
			end

			if 1.03333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 1.03333333333333 + arg_418_0 then
				arg_415_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fight04_loop", "")
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_16 = 2.5
			local var_418_17 = 1.775

			if 2.5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_18 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_18:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_19 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(320271100).content)

				arg_415_1.text_.text = var_418_19

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_21 = 71 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_19) / 71)

				if (71 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_19) / 71)) > 0 and var_418_17 < var_418_21 then
					arg_415_1.talkMaxDuration = var_418_21
					var_418_16 = var_418_16 + 0.3

					if var_418_21 + var_418_16 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_21 + var_418_16
					end
				end

				arg_415_1.text_.text = var_418_19
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_22 = var_418_16 + 0.3
			local var_418_23 = math.max(var_418_17, arg_415_1.talkMaxDuration)

			if var_418_16 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_22 + var_418_23 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_22) / var_418_23

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_22 + var_418_23 and arg_415_1.time_ < var_418_22 + var_418_23 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play320271101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320271101
		arg_421_1.duration_ = 6.37

		local var_421_0 = {
			zh = 3.166,
			ja = 6.366
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320271102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.4

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:GetWordFromCfg(320271101)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 16 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 16)

				if (16 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 16)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271101", "story_v_out_320271.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271101", "story_v_out_320271.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_320271", "320271101", "story_v_out_320271.awb")

						arg_421_1:RecordAudio("320271101", var_424_6)
						arg_421_1:RecordAudio("320271101", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_320271", "320271101", "story_v_out_320271.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_320271", "320271101", "story_v_out_320271.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play320271102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 320271102
		arg_425_1.duration_ = 6.3

		local var_425_0 = {
			zh = 4.3,
			ja = 6.3
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play320271103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.6

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:GetWordFromCfg(320271102)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 24 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 24)

				if (24 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 24)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271102", "story_v_out_320271.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271102", "story_v_out_320271.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_320271", "320271102", "story_v_out_320271.awb")

						arg_425_1:RecordAudio("320271102", var_428_6)
						arg_425_1:RecordAudio("320271102", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_320271", "320271102", "story_v_out_320271.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_320271", "320271102", "story_v_out_320271.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play320271103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 320271103
		arg_429_1.duration_ = 5.3

		local var_429_0 = {
			zh = 5.3,
			ja = 4.166
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play320271104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.5

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_1 = arg_429_1:GetWordFromCfg(320271103)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 20 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 20)

				if (20 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 20)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271103", "story_v_out_320271.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271103", "story_v_out_320271.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_out_320271", "320271103", "story_v_out_320271.awb")

						arg_429_1:RecordAudio("320271103", var_432_6)
						arg_429_1:RecordAudio("320271103", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_320271", "320271103", "story_v_out_320271.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_320271", "320271103", "story_v_out_320271.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play320271104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 320271104
		arg_433_1.duration_ = 5.97

		local var_433_0 = {
			zh = 5.766666666666,
			ja = 5.966
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play320271105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 2 < arg_433_1.time_ and arg_433_1.time_ <= 2 + arg_436_0 then
				local var_436_0 = arg_433_1.bgs_.ST69

				arg_433_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_436_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_436_1 = var_436_0:GetComponent("SpriteRenderer")

				if var_436_1 and var_436_1.sprite then
					local var_436_2 = 2 * (var_436_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_436_0.transform.localScale = Vector3.New(var_436_2 / var_436_1.sprite.bounds.size.y < var_436_2 * manager.ui.mainCameraCom_.aspect / var_436_1.sprite.bounds.size.x and var_436_2 * manager.ui.mainCameraCom_.aspect / var_436_1.sprite.bounds.size.x or var_436_2 / var_436_1.sprite.bounds.size.y, var_436_2 / var_436_1.sprite.bounds.size.y < var_436_2 * manager.ui.mainCameraCom_.aspect / var_436_1.sprite.bounds.size.x and var_436_2 * manager.ui.mainCameraCom_.aspect / var_436_1.sprite.bounds.size.x or var_436_2 / var_436_1.sprite.bounds.size.y, 0)
				end

				for iter_436_0, iter_436_1 in pairs(arg_433_1.bgs_) do
					if iter_436_0 ~= "ST69" then
						iter_436_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_436_3 = 0

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_3 + arg_436_0 then
				arg_433_1.allBtn_.enabled = false
			end

			if arg_433_1.time_ >= var_436_3 + 0.3 and arg_433_1.time_ < var_436_3 + 0.3 + arg_436_0 then
				arg_433_1.allBtn_.enabled = true
			end

			local var_436_4 = 0

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.mask_.enabled = true
				arg_433_1.mask_.raycastTarget = true

				arg_433_1:SetGaussion(false)
			end

			local var_436_5 = 2

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_5 then
				local var_436_6 = Color.New(0, 0, 0)

				var_436_6.a = Mathf.Lerp(0, 1, (arg_433_1.time_ - var_436_4) / var_436_5)
				arg_433_1.mask_.color = var_436_6
			end

			if arg_433_1.time_ >= var_436_4 + var_436_5 and arg_433_1.time_ < var_436_4 + var_436_5 + arg_436_0 then
				local var_436_7 = Color.New(0, 0, 0)

				var_436_7.a = 1
				arg_433_1.mask_.color = var_436_7
			end

			local var_436_8 = 2

			if 2 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 then
				arg_433_1.mask_.enabled = true
				arg_433_1.mask_.raycastTarget = true

				arg_433_1:SetGaussion(false)
			end

			local var_436_9 = 2

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_9 then
				local var_436_10 = Color.New(0, 0, 0)

				var_436_10.a = Mathf.Lerp(1, 0, (arg_433_1.time_ - var_436_8) / var_436_9)
				arg_433_1.mask_.color = var_436_10
			end

			if arg_433_1.time_ >= var_436_8 + var_436_9 and arg_433_1.time_ < var_436_8 + var_436_9 + arg_436_0 then
				local var_436_11 = Color.New(0, 0, 0)

				arg_433_1.mask_.enabled = false
				var_436_11.a = 0
				arg_433_1.mask_.color = var_436_11
			end

			local var_436_12 = arg_433_1.actors_["1061ui_story"].transform

			if 3.76666666666667 < arg_433_1.time_ and arg_433_1.time_ <= 3.76666666666667 + arg_436_0 then
				arg_433_1.var_.moveOldPos1061ui_story = var_436_12.localPosition
			end

			local var_436_13 = 0.001

			if 3.76666666666667 <= arg_433_1.time_ and arg_433_1.time_ < 3.76666666666667 + var_436_13 then
				var_436_12.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_433_1.time_ - 3.76666666666667) / var_436_13)
				var_436_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_12.position).x, (manager.ui.mainCamera.transform.position - var_436_12.position).y, (manager.ui.mainCamera.transform.position - var_436_12.position).z)
				var_436_12.localEulerAngles.z = 0
				var_436_12.localEulerAngles.x = 0
				var_436_12.localEulerAngles = var_436_12.localEulerAngles
			end

			if arg_433_1.time_ >= 3.76666666666667 + var_436_13 and arg_433_1.time_ < 3.76666666666667 + var_436_13 + arg_436_0 then
				var_436_12.localPosition = Vector3.New(0, -1.18, -6.15)
				var_436_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_12.position).x, (manager.ui.mainCamera.transform.position - var_436_12.position).y, (manager.ui.mainCamera.transform.position - var_436_12.position).z)
				var_436_12.localEulerAngles.z = 0
				var_436_12.localEulerAngles.x = 0
				var_436_12.localEulerAngles = var_436_12.localEulerAngles
			end

			local var_436_14 = arg_433_1.actors_["1061ui_story"]

			if 3.76666666666667 < arg_433_1.time_ and arg_433_1.time_ <= 3.76666666666667 + arg_436_0 and not isNil(var_436_14) and arg_433_1.var_.characterEffect1061ui_story == nil then
				arg_433_1.var_.characterEffect1061ui_story = var_436_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_15 = 0.200000002980232

			if 3.76666666666667 <= arg_433_1.time_ and arg_433_1.time_ < 3.76666666666667 + var_436_15 and not isNil(var_436_14) then
				if arg_433_1.var_.characterEffect1061ui_story and not isNil(var_436_14) then
					arg_433_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 3.76666666666667 + var_436_15 and arg_433_1.time_ < 3.76666666666667 + var_436_15 + arg_436_0 and not isNil(var_436_14) and arg_433_1.var_.characterEffect1061ui_story then
				arg_433_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.76666666666667 < arg_433_1.time_ and arg_433_1.time_ <= 3.76666666666667 + arg_436_0 then
				arg_433_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.43333333333333 < arg_433_1.time_ and arg_433_1.time_ <= 1.43333333333333 + arg_436_0 then
				arg_433_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_436_19 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_433_1.bgmTxt_.text ~= var_436_19 and arg_433_1.bgmTxt_.text ~= "" then
						if arg_433_1.bgmTxt2_.text ~= "" then
							arg_433_1.bgmTxt_.text = arg_433_1.bgmTxt2_.text
						end

						arg_433_1.bgmTxt2_.text = var_436_19

						arg_433_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_433_1.bgmTxt_.text = var_436_19
						arg_433_1.bgmTxt2_.text = var_436_19
					end

					if arg_433_1.bgmTimer then
						arg_433_1.bgmTimer:Stop()

						arg_433_1.bgmTimer = nil
					end

					if arg_433_1.settingData.show_music_name == 1 then
						arg_433_1.musicController:SetSelectedState("show")
						arg_433_1.musicAnimator_:Play("open", 0, 0)

						if arg_433_1.settingData.music_time ~= 0 then
							arg_433_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_433_1.settingData.music_time), function()
								if arg_433_1 == nil or isNil(arg_433_1.bgmTxt_) then
									return
								end

								arg_433_1.musicController:SetSelectedState("hide")
								arg_433_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.76666666666667 < arg_433_1.time_ and arg_433_1.time_ <= 3.76666666666667 + arg_436_0 then
				arg_433_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_436_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_433_1.bgmTxt_.text ~= var_436_22 and arg_433_1.bgmTxt_.text ~= "" then
						if arg_433_1.bgmTxt2_.text ~= "" then
							arg_433_1.bgmTxt_.text = arg_433_1.bgmTxt2_.text
						end

						arg_433_1.bgmTxt2_.text = var_436_22

						arg_433_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_433_1.bgmTxt_.text = var_436_22
						arg_433_1.bgmTxt2_.text = var_436_22
					end

					if arg_433_1.bgmTimer then
						arg_433_1.bgmTimer:Stop()

						arg_433_1.bgmTimer = nil
					end

					if arg_433_1.settingData.show_music_name == 1 then
						arg_433_1.musicController:SetSelectedState("show")
						arg_433_1.musicAnimator_:Play("open", 0, 0)

						if arg_433_1.settingData.music_time ~= 0 then
							arg_433_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_433_1.settingData.music_time), function()
								if arg_433_1 == nil or isNil(arg_433_1.bgmTxt_) then
									return
								end

								arg_433_1.musicController:SetSelectedState("hide")
								arg_433_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_fight04_loop", "")
			end

			if arg_433_1.frameCnt_ <= 1 then
				arg_433_1.dialog_:SetActive(false)
			end

			local var_436_24 = 4
			local var_436_25 = 0.175

			if 4 < arg_433_1.time_ and arg_433_1.time_ <= var_436_24 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0

				arg_433_1.dialog_:SetActive(true)

				arg_433_1.dialogCg_.alpha = 0

				local var_436_26 = LeanTween.value(arg_433_1.dialog_, 0, 1, 0.3)

				var_436_26:setOnUpdate(LuaHelper.FloatAction(function(arg_439_0)
					arg_433_1.dialogCg_.alpha = arg_439_0
				end))
				var_436_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_433_1.dialog_)
					var_436_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_433_1.duration_ = arg_433_1.duration_ + 0.3

				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_27 = arg_433_1:GetWordFromCfg(320271104)
				local var_436_28 = arg_433_1:FormatText(var_436_27.content)

				arg_433_1.text_.text = var_436_28

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_30 = 7 <= 0 and var_436_25 or var_436_25 * (utf8.len(var_436_28) / 7)

				if (7 <= 0 and var_436_25 or var_436_25 * (utf8.len(var_436_28) / 7)) > 0 and var_436_25 < var_436_30 then
					arg_433_1.talkMaxDuration = var_436_30
					var_436_24 = var_436_24 + 0.3

					if var_436_30 + var_436_24 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_30 + var_436_24
					end
				end

				arg_433_1.text_.text = var_436_28
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271104", "story_v_out_320271.awb") ~= 0 then
					local var_436_31 = manager.audio:GetVoiceLength("story_v_out_320271", "320271104", "story_v_out_320271.awb") / 1000

					if var_436_31 + var_436_24 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_31 + var_436_24
					end

					if var_436_27.prefab_name ~= "" and arg_433_1.actors_[var_436_27.prefab_name] ~= nil then
						local var_436_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_27.prefab_name].transform, "story_v_out_320271", "320271104", "story_v_out_320271.awb")

						arg_433_1:RecordAudio("320271104", var_436_32)
						arg_433_1:RecordAudio("320271104", var_436_32)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_320271", "320271104", "story_v_out_320271.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_320271", "320271104", "story_v_out_320271.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_33 = var_436_24 + 0.3
			local var_436_34 = math.max(var_436_25, arg_433_1.talkMaxDuration)

			if var_436_24 + 0.3 <= arg_433_1.time_ and arg_433_1.time_ < var_436_33 + var_436_34 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_33) / var_436_34

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_33 + var_436_34 and arg_433_1.time_ < var_436_33 + var_436_34 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play320271105 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 320271105
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play320271106(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1061ui_story = arg_441_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).z)
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles = arg_441_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_441_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1061ui_story"].transform.position).z)
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1061ui_story"].transform.localEulerAngles = arg_441_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1061ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1061ui_story == nil then
				arg_441_1.var_.characterEffect1061ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1061ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_2)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1061ui_story then
				arg_441_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_444_3 = 0
			local var_444_4 = 1.45

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_3 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_5 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(320271105).content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 58 <= 0 and var_444_4 or var_444_4 * (utf8.len(var_444_5) / 58)

				if (58 <= 0 and var_444_4 or var_444_4 * (utf8.len(var_444_5) / 58)) > 0 and var_444_4 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_3 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_3
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_4, arg_441_1.talkMaxDuration)

			if var_444_3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_3 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_3) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_3 + var_444_8 and arg_441_1.time_ < var_444_3 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play320271106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 320271106
		arg_445_1.duration_ = 9.7

		local var_445_0 = {
			zh = 8.233,
			ja = 9.7
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play320271107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1061ui_story = arg_445_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).z)
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles = arg_445_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_445_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1061ui_story"].transform.position).z)
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1061ui_story"].transform.localEulerAngles = arg_445_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["1061ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1061ui_story == nil then
				arg_445_1.var_.characterEffect1061ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect1061ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1061ui_story then
				arg_445_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_448_4 = 0
			local var_448_5 = 1.025

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(320271106)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 41 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 41)

				if (41 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 41)) > 0 and var_448_5 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271106", "story_v_out_320271.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_out_320271", "320271106", "story_v_out_320271.awb") / 1000

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end

					if var_448_6.prefab_name ~= "" and arg_445_1.actors_[var_448_6.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_6.prefab_name].transform, "story_v_out_320271", "320271106", "story_v_out_320271.awb")

						arg_445_1:RecordAudio("320271106", var_448_11)
						arg_445_1:RecordAudio("320271106", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_320271", "320271106", "story_v_out_320271.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_320271", "320271106", "story_v_out_320271.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_12 and arg_445_1.time_ < var_448_4 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play320271107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 320271107
		arg_449_1.duration_ = 14.23

		local var_449_0 = {
			zh = 11.2,
			ja = 14.233
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play320271108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_452_0 = 0
			local var_452_1 = 1.4

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_2 = arg_449_1:GetWordFromCfg(320271107)
				local var_452_3 = arg_449_1:FormatText(var_452_2.content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 56 <= 0 and var_452_1 or var_452_1 * (utf8.len(var_452_3) / 56)

				if (56 <= 0 and var_452_1 or var_452_1 * (utf8.len(var_452_3) / 56)) > 0 and var_452_1 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271107", "story_v_out_320271.awb") ~= 0 then
					local var_452_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271107", "story_v_out_320271.awb") / 1000

					if var_452_6 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_6 + var_452_0
					end

					if var_452_2.prefab_name ~= "" and arg_449_1.actors_[var_452_2.prefab_name] ~= nil then
						local var_452_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_2.prefab_name].transform, "story_v_out_320271", "320271107", "story_v_out_320271.awb")

						arg_449_1:RecordAudio("320271107", var_452_7)
						arg_449_1:RecordAudio("320271107", var_452_7)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_320271", "320271107", "story_v_out_320271.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_320271", "320271107", "story_v_out_320271.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play320271108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 320271108
		arg_453_1.duration_ = 14.63

		local var_453_0 = {
			zh = 10.5,
			ja = 14.633
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play320271109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 1.225

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:GetWordFromCfg(320271108)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 49 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 49)

				if (49 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 49)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271108", "story_v_out_320271.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271108", "story_v_out_320271.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_320271", "320271108", "story_v_out_320271.awb")

						arg_453_1:RecordAudio("320271108", var_456_6)
						arg_453_1:RecordAudio("320271108", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_320271", "320271108", "story_v_out_320271.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_320271", "320271108", "story_v_out_320271.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play320271109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 320271109
		arg_457_1.duration_ = 16.8

		local var_457_0 = {
			zh = 15.266,
			ja = 16.8
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play320271110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.7

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(320271109)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 68 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 68)

				if (68 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 68)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271109", "story_v_out_320271.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271109", "story_v_out_320271.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_320271", "320271109", "story_v_out_320271.awb")

						arg_457_1:RecordAudio("320271109", var_460_6)
						arg_457_1:RecordAudio("320271109", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_320271", "320271109", "story_v_out_320271.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_320271", "320271109", "story_v_out_320271.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play320271110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 320271110
		arg_461_1.duration_ = 10.53

		local var_461_0 = {
			zh = 7.733,
			ja = 10.533
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play320271111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.9

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:GetWordFromCfg(320271110)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 36 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 36)

				if (36 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 36)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271110", "story_v_out_320271.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271110", "story_v_out_320271.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_320271", "320271110", "story_v_out_320271.awb")

						arg_461_1:RecordAudio("320271110", var_464_6)
						arg_461_1:RecordAudio("320271110", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_320271", "320271110", "story_v_out_320271.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_320271", "320271110", "story_v_out_320271.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play320271111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 320271111
		arg_465_1.duration_ = 12.7

		local var_465_0 = {
			zh = 12.5,
			ja = 12.7
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play320271112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			local var_468_0 = 0
			local var_468_1 = 1.2

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(320271111)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 48 <= 0 and var_468_1 or var_468_1 * (utf8.len(var_468_3) / 48)

				if (48 <= 0 and var_468_1 or var_468_1 * (utf8.len(var_468_3) / 48)) > 0 and var_468_1 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271111", "story_v_out_320271.awb") ~= 0 then
					local var_468_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271111", "story_v_out_320271.awb") / 1000

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end

					if var_468_2.prefab_name ~= "" and arg_465_1.actors_[var_468_2.prefab_name] ~= nil then
						local var_468_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_2.prefab_name].transform, "story_v_out_320271", "320271111", "story_v_out_320271.awb")

						arg_465_1:RecordAudio("320271111", var_468_7)
						arg_465_1:RecordAudio("320271111", var_468_7)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_320271", "320271111", "story_v_out_320271.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_320271", "320271111", "story_v_out_320271.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_8 and arg_465_1.time_ < var_468_0 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play320271112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 320271112
		arg_469_1.duration_ = 17.53

		local var_469_0 = {
			zh = 17.533,
			ja = 12.9
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play320271113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 1.85

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:GetWordFromCfg(320271112)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 74 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 74)

				if (74 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 74)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271112", "story_v_out_320271.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271112", "story_v_out_320271.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_320271", "320271112", "story_v_out_320271.awb")

						arg_469_1:RecordAudio("320271112", var_472_6)
						arg_469_1:RecordAudio("320271112", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_320271", "320271112", "story_v_out_320271.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_320271", "320271112", "story_v_out_320271.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play320271113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 320271113
		arg_473_1.duration_ = 14.3

		local var_473_0 = {
			zh = 13.8,
			ja = 14.3
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play320271114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_476_0 = 0
			local var_476_1 = 1.45

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(320271113)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 58 <= 0 and var_476_1 or var_476_1 * (utf8.len(var_476_3) / 58)

				if (58 <= 0 and var_476_1 or var_476_1 * (utf8.len(var_476_3) / 58)) > 0 and var_476_1 < var_476_5 then
					arg_473_1.talkMaxDuration = var_476_5

					if var_476_5 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271113", "story_v_out_320271.awb") ~= 0 then
					local var_476_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271113", "story_v_out_320271.awb") / 1000

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end

					if var_476_2.prefab_name ~= "" and arg_473_1.actors_[var_476_2.prefab_name] ~= nil then
						local var_476_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_2.prefab_name].transform, "story_v_out_320271", "320271113", "story_v_out_320271.awb")

						arg_473_1:RecordAudio("320271113", var_476_7)
						arg_473_1:RecordAudio("320271113", var_476_7)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_320271", "320271113", "story_v_out_320271.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_320271", "320271113", "story_v_out_320271.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play320271114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 320271114
		arg_477_1.duration_ = 12.1

		local var_477_0 = {
			zh = 12.1,
			ja = 8.466
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play320271115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 1.5

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:GetWordFromCfg(320271114)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 60 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 60)

				if (60 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 60)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271114", "story_v_out_320271.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_320271", "320271114", "story_v_out_320271.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_320271", "320271114", "story_v_out_320271.awb")

						arg_477_1:RecordAudio("320271114", var_480_6)
						arg_477_1:RecordAudio("320271114", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_320271", "320271114", "story_v_out_320271.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_320271", "320271114", "story_v_out_320271.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play320271115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 320271115
		arg_481_1.duration_ = 12.7

		local var_481_0 = {
			zh = 9.366,
			ja = 12.7
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play320271116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1061ui_story"]) and arg_481_1.var_.characterEffect1061ui_story == nil then
				arg_481_1.var_.characterEffect1061ui_story = arg_481_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1061ui_story"]) then
				if arg_481_1.var_.characterEffect1061ui_story and not isNil(arg_481_1.actors_["1061ui_story"]) then
					arg_481_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1061ui_story"]) and arg_481_1.var_.characterEffect1061ui_story then
				arg_481_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			local var_484_2 = 0
			local var_484_3 = 0.975

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:GetWordFromCfg(320271115)
				local var_484_5 = arg_481_1:FormatText(var_484_4.content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 39 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 39)

				if (39 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 39)) > 0 and var_484_3 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271115", "story_v_out_320271.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_320271", "320271115", "story_v_out_320271.awb") / 1000

					if var_484_8 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_2
					end

					if var_484_4.prefab_name ~= "" and arg_481_1.actors_[var_484_4.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_4.prefab_name].transform, "story_v_out_320271", "320271115", "story_v_out_320271.awb")

						arg_481_1:RecordAudio("320271115", var_484_9)
						arg_481_1:RecordAudio("320271115", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_320271", "320271115", "story_v_out_320271.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_320271", "320271115", "story_v_out_320271.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_10 and arg_481_1.time_ < var_484_2 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play320271116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 320271116
		arg_485_1.duration_ = 4.3

		local var_485_0 = {
			zh = 1.999999999999,
			ja = 4.3
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
			arg_485_1.auto_ = false
		end

		function arg_485_1.playNext_(arg_487_0)
			arg_485_1.onStoryFinished_()
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_488_0 = 0
			local var_488_1 = 0.2

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:GetWordFromCfg(320271116)
				local var_488_3 = arg_485_1:FormatText(var_488_2.content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 8 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 8)

				if (8 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 8)) > 0 and var_488_1 < var_488_5 then
					arg_485_1.talkMaxDuration = var_488_5

					if var_488_5 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320271", "320271116", "story_v_out_320271.awb") ~= 0 then
					local var_488_6 = manager.audio:GetVoiceLength("story_v_out_320271", "320271116", "story_v_out_320271.awb") / 1000

					if var_488_6 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_0
					end

					if var_488_2.prefab_name ~= "" and arg_485_1.actors_[var_488_2.prefab_name] ~= nil then
						local var_488_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_2.prefab_name].transform, "story_v_out_320271", "320271116", "story_v_out_320271.awb")

						arg_485_1:RecordAudio("320271116", var_488_7)
						arg_485_1:RecordAudio("320271116", var_488_7)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_320271", "320271116", "story_v_out_320271.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_320271", "320271116", "story_v_out_320271.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/L07k"
	},
	voices = {
		"story_v_out_320271.awb"
	}
}

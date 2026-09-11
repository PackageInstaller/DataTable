return {
	Play116411001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116411001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116411002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST15 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_4_0.name = "ST15"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST15 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST15

				arg_1_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST15" then
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

			local var_4_8 = 0

			arg_1_1.isInRecall_ = false

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_9 = 0.0166666666666667

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_8) / var_4_9)
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116411001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 12 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 12)

				if (12 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 12)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116411002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116411002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116411003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10025ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10025ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10025ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10025ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10025ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10025ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10025ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10025ui_story == nil then
				arg_9_1.var_.characterEffect10025ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10025ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10025ui_story then
				arg_9_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(116411002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)

				if (3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411002", "story_v_out_116411.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_116411", "116411002", "story_v_out_116411.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_116411", "116411002", "story_v_out_116411.awb")

						arg_9_1:RecordAudio("116411002", var_12_15)
						arg_9_1:RecordAudio("116411002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116411", "116411002", "story_v_out_116411.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116411", "116411002", "story_v_out_116411.awb")
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
				actorName = "10025ui_story",
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
	Play116411003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116411003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116411004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10025ui_story"]) and arg_13_1.var_.characterEffect10025ui_story == nil then
				arg_13_1.var_.characterEffect10025ui_story = arg_13_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10025ui_story"]) then
				if arg_13_1.var_.characterEffect10025ui_story and not isNil(arg_13_1.actors_["10025ui_story"]) then
					arg_13_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10025ui_story"]) and arg_13_1.var_.characterEffect10025ui_story then
				arg_13_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116411003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 29 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 29)

				if (29 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 29)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116411004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116411004
		arg_17_1.duration_ = 8.33

		local var_17_0 = {
			zh = 7.633,
			ja = 8.333
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
				arg_17_0:Play116411005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10025ui_story = arg_17_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).z)
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles = arg_17_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_17_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10025ui_story"].transform.position).z)
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10025ui_story"].transform.localEulerAngles = arg_17_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_20_1 = arg_17_1.actors_["10025ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10025ui_story == nil then
				arg_17_1.var_.characterEffect10025ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10025ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10025ui_story then
				arg_17_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(116411004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)

				if (28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411004", "story_v_out_116411.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411004", "story_v_out_116411.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_116411", "116411004", "story_v_out_116411.awb")

						arg_17_1:RecordAudio("116411004", var_20_11)
						arg_17_1:RecordAudio("116411004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116411", "116411004", "story_v_out_116411.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116411", "116411004", "story_v_out_116411.awb")
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

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play116411005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116411005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116411006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10025ui_story"]) and arg_21_1.var_.characterEffect10025ui_story == nil then
				arg_21_1.var_.characterEffect10025ui_story = arg_21_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10025ui_story"]) then
				if arg_21_1.var_.characterEffect10025ui_story and not isNil(arg_21_1.actors_["10025ui_story"]) then
					arg_21_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10025ui_story"]) and arg_21_1.var_.characterEffect10025ui_story then
				arg_21_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.225

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(116411005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 9 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 9)

				if (9 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 9)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play116411006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116411006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116411007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.95

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(116411006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 38 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 38)

				if (38 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 38)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116411007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116411007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116411008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(116411007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 20 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 20)

				if (20 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 20)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116411008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116411008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116411009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_0 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				local var_36_1 = Color.New(1, 1, 1)

				var_36_1.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.mask_.color = var_36_1
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				local var_36_2 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_2.a = 0
				arg_33_1.mask_.color = var_36_2
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_16", "se_story_16_camera", "")
			end

			local var_36_4 = arg_33_1.actors_["10025ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10025ui_story = var_36_4.localPosition
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_4.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_5)
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
			local var_36_7 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_8 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_8:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(116411008).content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 4 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 4)

				if (4 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 4)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11
					var_36_6 = var_36_6 + 0.3

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = var_36_6 + 0.3
			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_13 and arg_33_1.time_ < var_36_12 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
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
	Play116411009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116411009
		arg_39_1.duration_ = 4.07

		local var_39_0 = {
			zh = 4.066,
			ja = 3.866
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116411010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10025ui_story = arg_39_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).z)
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles = arg_39_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_39_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["10025ui_story"].transform.position).z)
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["10025ui_story"].transform.localEulerAngles = arg_39_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["10025ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect10025ui_story == nil then
				arg_39_1.var_.characterEffect10025ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect10025ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect10025ui_story then
				arg_39_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_42_4 = 0
			local var_42_5 = 0.325

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(116411009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 13 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 13)

				if (13 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 13)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411009", "story_v_out_116411.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411009", "story_v_out_116411.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_116411", "116411009", "story_v_out_116411.awb")

						arg_39_1:RecordAudio("116411009", var_42_11)
						arg_39_1:RecordAudio("116411009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116411", "116411009", "story_v_out_116411.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116411", "116411009", "story_v_out_116411.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play116411010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116411010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116411011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10025ui_story"]) and arg_43_1.var_.characterEffect10025ui_story == nil then
				arg_43_1.var_.characterEffect10025ui_story = arg_43_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10025ui_story"]) then
				if arg_43_1.var_.characterEffect10025ui_story and not isNil(arg_43_1.actors_["10025ui_story"]) then
					arg_43_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_43_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10025ui_story"]) and arg_43_1.var_.characterEffect10025ui_story then
				arg_43_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_43_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.525

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(116411010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 21 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 21)

				if (21 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 21)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116411011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116411011
		arg_47_1.duration_ = 8.77

		local var_47_0 = {
			zh = 8.766,
			ja = 7.166
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
				arg_47_0:Play116411012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.I05f == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_50_0.name = "I05f"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.I05f = var_50_0
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.I05f

				arg_47_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "I05f" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_5 = 2

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_5 then
				local var_50_6 = Color.New(1, 1, 1)

				var_50_6.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_4) / var_50_5)
				arg_47_1.mask_.color = var_50_6
			end

			if arg_47_1.time_ >= var_50_4 + var_50_5 and arg_47_1.time_ < var_50_4 + var_50_5 + arg_50_0 then
				local var_50_7 = Color.New(1, 1, 1)

				var_50_7.a = 1
				arg_47_1.mask_.color = var_50_7
			end

			local var_50_8 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = Color.New(1, 1, 1)

				var_50_10.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_8) / var_50_9)
				arg_47_1.mask_.color = var_50_10
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 then
				local var_50_11 = Color.New(1, 1, 1)

				arg_47_1.mask_.enabled = false
				var_50_11.a = 0
				arg_47_1.mask_.color = var_50_11
			end

			local var_50_12 = 0

			arg_47_1.isInRecall_ = false

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.screenFilterGo_:SetActive(false)

				for iter_50_2, iter_50_3 in pairs(arg_47_1.actors_) do
					for iter_50_4, iter_50_5 in ipairs((iter_50_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_50_5.color = iter_50_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_50_13 = 0.0166666666666667

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_13 then
				arg_47_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_12) / var_50_13)
			end

			if arg_47_1.time_ >= var_50_12 + var_50_13 and arg_47_1.time_ < var_50_12 + var_50_13 + arg_50_0 then
				arg_47_1.screenFilterEffect_.weight = 0
			end

			local var_50_14 = arg_47_1.actors_["10025ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10025ui_story = var_50_14.localPosition
			end

			local var_50_15 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_15 then
				var_50_14.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_15)
				var_50_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_14.position).x, (manager.ui.mainCamera.transform.position - var_50_14.position).y, (manager.ui.mainCamera.transform.position - var_50_14.position).z)
				var_50_14.localEulerAngles.z = 0
				var_50_14.localEulerAngles.x = 0
				var_50_14.localEulerAngles = var_50_14.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_15 and arg_47_1.time_ < 0 + var_50_15 + arg_50_0 then
				var_50_14.localPosition = Vector3.New(0, 100, 0)
				var_50_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_14.position).x, (manager.ui.mainCamera.transform.position - var_50_14.position).y, (manager.ui.mainCamera.transform.position - var_50_14.position).z)
				var_50_14.localEulerAngles.z = 0
				var_50_14.localEulerAngles.x = 0
				var_50_14.localEulerAngles = var_50_14.localEulerAngles
			end

			local var_50_16 = arg_47_1.actors_["10025ui_story"].transform

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				arg_47_1.var_.moveOldPos10025ui_story = var_50_16.localPosition
			end

			local var_50_17 = 0.001

			if 2 <= arg_47_1.time_ and arg_47_1.time_ < 2 + var_50_17 then
				var_50_16.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_47_1.time_ - 2) / var_50_17)
				var_50_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_16.position).x, (manager.ui.mainCamera.transform.position - var_50_16.position).y, (manager.ui.mainCamera.transform.position - var_50_16.position).z)
				var_50_16.localEulerAngles.z = 0
				var_50_16.localEulerAngles.x = 0
				var_50_16.localEulerAngles = var_50_16.localEulerAngles
			end

			if arg_47_1.time_ >= 2 + var_50_17 and arg_47_1.time_ < 2 + var_50_17 + arg_50_0 then
				var_50_16.localPosition = Vector3.New(0, -1.1, -5.9)
				var_50_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_16.position).x, (manager.ui.mainCamera.transform.position - var_50_16.position).y, (manager.ui.mainCamera.transform.position - var_50_16.position).z)
				var_50_16.localEulerAngles.z = 0
				var_50_16.localEulerAngles.x = 0
				var_50_16.localEulerAngles = var_50_16.localEulerAngles
			end

			local var_50_18 = arg_47_1.actors_["10025ui_story"]

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect10025ui_story == nil then
				arg_47_1.var_.characterEffect10025ui_story = var_50_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_19 = 0.2

			if 2 <= arg_47_1.time_ and arg_47_1.time_ < 2 + var_50_19 and not isNil(var_50_18) then
				if arg_47_1.var_.characterEffect10025ui_story and not isNil(var_50_18) then
					arg_47_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 2 + var_50_19 and arg_47_1.time_ < 2 + var_50_19 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect10025ui_story then
				arg_47_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				arg_47_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				arg_47_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_21 = 4
			local var_50_22 = 0.275

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_23 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_23:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_24 = arg_47_1:GetWordFromCfg(116411011)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_27 = 11 <= 0 and var_50_22 or var_50_22 * (utf8.len(var_50_25) / 11)

				if (11 <= 0 and var_50_22 or var_50_22 * (utf8.len(var_50_25) / 11)) > 0 and var_50_22 < var_50_27 then
					arg_47_1.talkMaxDuration = var_50_27
					var_50_21 = var_50_21 + 0.3

					if var_50_27 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_27 + var_50_21
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411011", "story_v_out_116411.awb") ~= 0 then
					local var_50_28 = manager.audio:GetVoiceLength("story_v_out_116411", "116411011", "story_v_out_116411.awb") / 1000

					if var_50_28 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_21
					end

					if var_50_24.prefab_name ~= "" and arg_47_1.actors_[var_50_24.prefab_name] ~= nil then
						local var_50_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_24.prefab_name].transform, "story_v_out_116411", "116411011", "story_v_out_116411.awb")

						arg_47_1:RecordAudio("116411011", var_50_29)
						arg_47_1:RecordAudio("116411011", var_50_29)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_116411", "116411011", "story_v_out_116411.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_116411", "116411011", "story_v_out_116411.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_30 = var_50_21 + 0.3
			local var_50_31 = math.max(var_50_22, arg_47_1.talkMaxDuration)

			if var_50_21 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_30 + var_50_31 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_30) / var_50_31

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_30 + var_50_31 and arg_47_1.time_ < var_50_30 + var_50_31 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play116411012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116411012
		arg_53_1.duration_ = 7

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116411013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.bgs_.I06 == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06")
				var_56_0.name = "I06"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.I06 = var_56_0
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.I06

				arg_53_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "I06" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_5 = 2

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_5 then
				local var_56_6 = Color.New(1, 1, 1)

				var_56_6.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_4) / var_56_5)
				arg_53_1.mask_.color = var_56_6
			end

			if arg_53_1.time_ >= var_56_4 + var_56_5 and arg_53_1.time_ < var_56_4 + var_56_5 + arg_56_0 then
				local var_56_7 = Color.New(1, 1, 1)

				arg_53_1.mask_.enabled = false
				var_56_7.a = 0
				arg_53_1.mask_.color = var_56_7
			end

			local var_56_8 = 0

			arg_53_1.isInRecall_ = false

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.screenFilterGo_:SetActive(true)

				arg_53_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_56_2, iter_56_3 in pairs(arg_53_1.actors_) do
					for iter_56_4, iter_56_5 in ipairs((iter_56_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_56_5.color = iter_56_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_56_9 = 0.0166666666666667

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 then
				arg_53_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_8) / var_56_9)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 then
				arg_53_1.screenFilterEffect_.weight = 1
			end

			local var_56_10 = arg_53_1.actors_["10025ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10025ui_story = var_56_10.localPosition
			end

			local var_56_11 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_11 then
				var_56_10.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_11)
				var_56_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_10.position).x, (manager.ui.mainCamera.transform.position - var_56_10.position).y, (manager.ui.mainCamera.transform.position - var_56_10.position).z)
				var_56_10.localEulerAngles.z = 0
				var_56_10.localEulerAngles.x = 0
				var_56_10.localEulerAngles = var_56_10.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_11 and arg_53_1.time_ < 0 + var_56_11 + arg_56_0 then
				var_56_10.localPosition = Vector3.New(0, 100, 0)
				var_56_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_10.position).x, (manager.ui.mainCamera.transform.position - var_56_10.position).y, (manager.ui.mainCamera.transform.position - var_56_10.position).z)
				var_56_10.localEulerAngles.z = 0
				var_56_10.localEulerAngles.x = 0
				var_56_10.localEulerAngles = var_56_10.localEulerAngles
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_12 = 2
			local var_56_13 = 0.45

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_14 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_14:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(116411012).content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 18 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 18)

				if (18 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 18)) > 0 and var_56_13 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17
					var_56_12 = var_56_12 + 0.3

					if var_56_17 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = var_56_12 + 0.3
			local var_56_19 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_18 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_18) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_18 + var_56_19 and arg_53_1.time_ < var_56_18 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play116411013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116411013
		arg_59_1.duration_ = 4.07

		local var_59_0 = {
			zh = 3.7,
			ja = 4.066
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
				arg_59_0:Play116411014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.35

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[347].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(116411013)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 14 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 14)

				if (14 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 14)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411013", "story_v_out_116411.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_116411", "116411013", "story_v_out_116411.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_116411", "116411013", "story_v_out_116411.awb")

						arg_59_1:RecordAudio("116411013", var_62_6)
						arg_59_1:RecordAudio("116411013", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116411", "116411013", "story_v_out_116411.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116411", "116411013", "story_v_out_116411.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play116411014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116411014
		arg_63_1.duration_ = 2.63

		local var_63_0 = {
			zh = 2.2,
			ja = 2.633
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116411015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10025ui_story = arg_63_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).z)
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles = arg_63_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_63_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10025ui_story"].transform.position).z)
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10025ui_story"].transform.localEulerAngles = arg_63_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["10025ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect10025ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10025ui_story then
				arg_63_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_66_4 = 0
			local var_66_5 = 0.175

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(116411014)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 7 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 7)

				if (7 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 7)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411014", "story_v_out_116411.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411014", "story_v_out_116411.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_116411", "116411014", "story_v_out_116411.awb")

						arg_63_1:RecordAudio("116411014", var_66_11)
						arg_63_1:RecordAudio("116411014", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_116411", "116411014", "story_v_out_116411.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_116411", "116411014", "story_v_out_116411.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play116411015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116411015
		arg_67_1.duration_ = 6.57

		local var_67_0 = {
			zh = 5.4,
			ja = 6.566
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
				arg_67_0:Play116411016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10025ui_story = arg_67_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).z)
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles = arg_67_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["10025ui_story"].transform.position).z)
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["10025ui_story"].transform.localEulerAngles = arg_67_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_70_1 = 0
			local var_70_2 = 0.575

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[347].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(116411015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 23 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 23)

				if (23 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 23)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411015", "story_v_out_116411.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_116411", "116411015", "story_v_out_116411.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_116411", "116411015", "story_v_out_116411.awb")

						arg_67_1:RecordAudio("116411015", var_70_8)
						arg_67_1:RecordAudio("116411015", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116411", "116411015", "story_v_out_116411.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116411", "116411015", "story_v_out_116411.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play116411016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116411016
		arg_71_1.duration_ = 7.27

		local var_71_0 = {
			zh = 3.233,
			ja = 7.266
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
				arg_71_0:Play116411017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10025ui_story = arg_71_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).z)
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles = arg_71_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_71_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10025ui_story"].transform.position).z)
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10025ui_story"].transform.localEulerAngles = arg_71_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10025ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10025ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10025ui_story then
				arg_71_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(116411016)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)

				if (12 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 12)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411016", "story_v_out_116411.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411016", "story_v_out_116411.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_116411", "116411016", "story_v_out_116411.awb")

						arg_71_1:RecordAudio("116411016", var_74_11)
						arg_71_1:RecordAudio("116411016", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116411", "116411016", "story_v_out_116411.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116411", "116411016", "story_v_out_116411.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play116411017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116411017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116411018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10025ui_story"]) and arg_75_1.var_.characterEffect10025ui_story == nil then
				arg_75_1.var_.characterEffect10025ui_story = arg_75_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10025ui_story"]) then
				if arg_75_1.var_.characterEffect10025ui_story and not isNil(arg_75_1.actors_["10025ui_story"]) then
					arg_75_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10025ui_story"]) and arg_75_1.var_.characterEffect10025ui_story then
				arg_75_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.25

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116411017).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 10 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 10)

				if (10 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 10)) > 0 and var_78_2 < var_78_5 then
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
	Play116411018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116411018
		arg_79_1.duration_ = 5.53

		local var_79_0 = {
			zh = 5.533,
			ja = 3.8
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116411019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10025ui_story = arg_79_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).z)
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles = arg_79_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_79_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10025ui_story"].transform.position).z)
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10025ui_story"].transform.localEulerAngles = arg_79_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10025ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10025ui_story == nil then
				arg_79_1.var_.characterEffect10025ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10025ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10025ui_story then
				arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(116411018)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 22 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 22)

				if (22 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 22)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411018", "story_v_out_116411.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411018", "story_v_out_116411.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_116411", "116411018", "story_v_out_116411.awb")

						arg_79_1:RecordAudio("116411018", var_82_11)
						arg_79_1:RecordAudio("116411018", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116411", "116411018", "story_v_out_116411.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116411", "116411018", "story_v_out_116411.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
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
	Play116411019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116411019
		arg_83_1.duration_ = 9.17

		local var_83_0 = {
			zh = 8.966,
			ja = 9.166
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116411020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 2 < arg_83_1.time_ and arg_83_1.time_ <= 2 + arg_86_0 then
				local var_86_0 = arg_83_1.bgs_.I05f

				arg_83_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_86_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_1 = var_86_0:GetComponent("SpriteRenderer")

				if var_86_1 and var_86_1.sprite then
					local var_86_2 = 2 * (var_86_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_86_0.transform.localScale = Vector3.New(var_86_2 / var_86_1.sprite.bounds.size.y < var_86_2 * manager.ui.mainCameraCom_.aspect / var_86_1.sprite.bounds.size.x and var_86_2 * manager.ui.mainCameraCom_.aspect / var_86_1.sprite.bounds.size.x or var_86_2 / var_86_1.sprite.bounds.size.y, var_86_2 / var_86_1.sprite.bounds.size.y < var_86_2 * manager.ui.mainCameraCom_.aspect / var_86_1.sprite.bounds.size.x and var_86_2 * manager.ui.mainCameraCom_.aspect / var_86_1.sprite.bounds.size.x or var_86_2 / var_86_1.sprite.bounds.size.y, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "I05f" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_3 = 0

			arg_83_1.isInRecall_ = false

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.screenFilterGo_:SetActive(false)

				for iter_86_2, iter_86_3 in pairs(arg_83_1.actors_) do
					for iter_86_4, iter_86_5 in ipairs((iter_86_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_86_5.color = iter_86_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_86_4 = 0.0166666666666667

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_4 then
				arg_83_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_3) / var_86_4)
			end

			if arg_83_1.time_ >= var_86_3 + var_86_4 and arg_83_1.time_ < var_86_3 + var_86_4 + arg_86_0 then
				arg_83_1.screenFilterEffect_.weight = 0
			end

			local var_86_5 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_6 = 2

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 then
				local var_86_7 = Color.New(1, 1, 1)

				var_86_7.a = Mathf.Lerp(0, 1, (arg_83_1.time_ - var_86_5) / var_86_6)
				arg_83_1.mask_.color = var_86_7
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 then
				local var_86_8 = Color.New(1, 1, 1)

				var_86_8.a = 1
				arg_83_1.mask_.color = var_86_8
			end

			local var_86_9 = 2

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_10 = 2

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_10 then
				local var_86_11 = Color.New(1, 1, 1)

				var_86_11.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_9) / var_86_10)
				arg_83_1.mask_.color = var_86_11
			end

			if arg_83_1.time_ >= var_86_9 + var_86_10 and arg_83_1.time_ < var_86_9 + var_86_10 + arg_86_0 then
				local var_86_12 = Color.New(1, 1, 1)

				arg_83_1.mask_.enabled = false
				var_86_12.a = 0
				arg_83_1.mask_.color = var_86_12
			end

			local var_86_13 = arg_83_1.actors_["10025ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10025ui_story = var_86_13.localPosition
			end

			local var_86_14 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_14 then
				var_86_13.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_14)
				var_86_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_13.position).x, (manager.ui.mainCamera.transform.position - var_86_13.position).y, (manager.ui.mainCamera.transform.position - var_86_13.position).z)
				var_86_13.localEulerAngles.z = 0
				var_86_13.localEulerAngles.x = 0
				var_86_13.localEulerAngles = var_86_13.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_14 and arg_83_1.time_ < 0 + var_86_14 + arg_86_0 then
				var_86_13.localPosition = Vector3.New(0, 100, 0)
				var_86_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_13.position).x, (manager.ui.mainCamera.transform.position - var_86_13.position).y, (manager.ui.mainCamera.transform.position - var_86_13.position).z)
				var_86_13.localEulerAngles.z = 0
				var_86_13.localEulerAngles.x = 0
				var_86_13.localEulerAngles = var_86_13.localEulerAngles
			end

			local var_86_15 = arg_83_1.actors_["10025ui_story"].transform

			if 3.8 < arg_83_1.time_ and arg_83_1.time_ <= 3.8 + arg_86_0 then
				arg_83_1.var_.moveOldPos10025ui_story = var_86_15.localPosition
			end

			local var_86_16 = 0.001

			if 3.8 <= arg_83_1.time_ and arg_83_1.time_ < 3.8 + var_86_16 then
				var_86_15.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_83_1.time_ - 3.8) / var_86_16)
				var_86_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_15.position).x, (manager.ui.mainCamera.transform.position - var_86_15.position).y, (manager.ui.mainCamera.transform.position - var_86_15.position).z)
				var_86_15.localEulerAngles.z = 0
				var_86_15.localEulerAngles.x = 0
				var_86_15.localEulerAngles = var_86_15.localEulerAngles
			end

			if arg_83_1.time_ >= 3.8 + var_86_16 and arg_83_1.time_ < 3.8 + var_86_16 + arg_86_0 then
				var_86_15.localPosition = Vector3.New(0, -1.1, -5.9)
				var_86_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_15.position).x, (manager.ui.mainCamera.transform.position - var_86_15.position).y, (manager.ui.mainCamera.transform.position - var_86_15.position).z)
				var_86_15.localEulerAngles.z = 0
				var_86_15.localEulerAngles.x = 0
				var_86_15.localEulerAngles = var_86_15.localEulerAngles
			end

			if 3.8 < arg_83_1.time_ and arg_83_1.time_ <= 3.8 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 3.8 < arg_83_1.time_ and arg_83_1.time_ <= 3.8 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_86_17 = arg_83_1.actors_["10025ui_story"]

			if 3.8 < arg_83_1.time_ and arg_83_1.time_ <= 3.8 + arg_86_0 and not isNil(var_86_17) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = var_86_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_18 = 0.2

			if 3.8 <= arg_83_1.time_ and arg_83_1.time_ < 3.8 + var_86_18 and not isNil(var_86_17) then
				if arg_83_1.var_.characterEffect10025ui_story and not isNil(var_86_17) then
					arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 3.8 + var_86_18 and arg_83_1.time_ < 3.8 + var_86_18 + arg_86_0 and not isNil(var_86_17) and arg_83_1.var_.characterEffect10025ui_story then
				arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_20 = 4
			local var_86_21 = 0.325

			if 4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_22 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_22:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_23 = arg_83_1:GetWordFromCfg(116411019)
				local var_86_24 = arg_83_1:FormatText(var_86_23.content)

				arg_83_1.text_.text = var_86_24

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_26 = 13 <= 0 and var_86_21 or var_86_21 * (utf8.len(var_86_24) / 13)

				if (13 <= 0 and var_86_21 or var_86_21 * (utf8.len(var_86_24) / 13)) > 0 and var_86_21 < var_86_26 then
					arg_83_1.talkMaxDuration = var_86_26
					var_86_20 = var_86_20 + 0.3

					if var_86_26 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_26 + var_86_20
					end
				end

				arg_83_1.text_.text = var_86_24
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411019", "story_v_out_116411.awb") ~= 0 then
					local var_86_27 = manager.audio:GetVoiceLength("story_v_out_116411", "116411019", "story_v_out_116411.awb") / 1000

					if var_86_27 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_20
					end

					if var_86_23.prefab_name ~= "" and arg_83_1.actors_[var_86_23.prefab_name] ~= nil then
						local var_86_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_23.prefab_name].transform, "story_v_out_116411", "116411019", "story_v_out_116411.awb")

						arg_83_1:RecordAudio("116411019", var_86_28)
						arg_83_1:RecordAudio("116411019", var_86_28)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_116411", "116411019", "story_v_out_116411.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_116411", "116411019", "story_v_out_116411.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_29 = var_86_20 + 0.3
			local var_86_30 = math.max(var_86_21, arg_83_1.talkMaxDuration)

			if var_86_20 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_29 + var_86_30 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_29) / var_86_30

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_29 + var_86_30 and arg_83_1.time_ < var_86_29 + var_86_30 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play116411020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116411020
		arg_89_1.duration_ = 7

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play116411021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.bgs_.ST03 == nil then
				local var_92_0 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_92_0.name = "ST03"
				var_92_0.transform.parent = arg_89_1.stage_.transform
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_.ST03 = var_92_0
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				local var_92_1 = arg_89_1.bgs_.ST03

				arg_89_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_2 = var_92_1:GetComponent("SpriteRenderer")

				if var_92_2 and var_92_2.sprite then
					local var_92_3 = 2 * (var_92_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_1.transform.localScale = Vector3.New(var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "ST03" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_4 = 0

			arg_89_1.isInRecall_ = false

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.screenFilterGo_:SetActive(true)

				arg_89_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_92_2, iter_92_3 in pairs(arg_89_1.actors_) do
					for iter_92_4, iter_92_5 in ipairs((iter_92_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_92_5.color = iter_92_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_92_5 = 0.0166666666666667

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_5 then
				arg_89_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_4) / var_92_5)
			end

			if arg_89_1.time_ >= var_92_4 + var_92_5 and arg_89_1.time_ < var_92_4 + var_92_5 + arg_92_0 then
				arg_89_1.screenFilterEffect_.weight = 1
			end

			local var_92_6 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_7 = 2

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_7 then
				local var_92_8 = Color.New(1, 1, 1)

				var_92_8.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_6) / var_92_7)
				arg_89_1.mask_.color = var_92_8
			end

			if arg_89_1.time_ >= var_92_6 + var_92_7 and arg_89_1.time_ < var_92_6 + var_92_7 + arg_92_0 then
				local var_92_9 = Color.New(1, 1, 1)

				arg_89_1.mask_.enabled = false
				var_92_9.a = 0
				arg_89_1.mask_.color = var_92_9
			end

			local var_92_10 = arg_89_1.actors_["10025ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10025ui_story = var_92_10.localPosition
			end

			local var_92_11 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_11 then
				var_92_10.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_11)
				var_92_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_10.position).x, (manager.ui.mainCamera.transform.position - var_92_10.position).y, (manager.ui.mainCamera.transform.position - var_92_10.position).z)
				var_92_10.localEulerAngles.z = 0
				var_92_10.localEulerAngles.x = 0
				var_92_10.localEulerAngles = var_92_10.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_11 and arg_89_1.time_ < 0 + var_92_11 + arg_92_0 then
				var_92_10.localPosition = Vector3.New(0, 100, 0)
				var_92_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_10.position).x, (manager.ui.mainCamera.transform.position - var_92_10.position).y, (manager.ui.mainCamera.transform.position - var_92_10.position).z)
				var_92_10.localEulerAngles.z = 0
				var_92_10.localEulerAngles.x = 0
				var_92_10.localEulerAngles = var_92_10.localEulerAngles
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_12 = 2
			local var_92_13 = 0.725

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_14 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_14:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(116411020).content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 29 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 29)

				if (29 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 29)) > 0 and var_92_13 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17
					var_92_12 = var_92_12 + 0.3

					if var_92_17 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_18 = var_92_12 + 0.3
			local var_92_19 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_18 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_18) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_18 + var_92_19 and arg_89_1.time_ < var_92_18 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play116411021 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116411021
		arg_95_1.duration_ = 3.63

		local var_95_0 = {
			zh = 3.633,
			ja = 1.999999999999
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116411022(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10025ui_story = arg_95_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).z)
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles = arg_95_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_95_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10025ui_story"].transform.position).z)
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10025ui_story"].transform.localEulerAngles = arg_95_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["10025ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10025ui_story == nil then
				arg_95_1.var_.characterEffect10025ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10025ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10025ui_story then
				arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.3

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(116411021)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 8 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 8)

				if (8 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 8)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411021", "story_v_out_116411.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411021", "story_v_out_116411.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_116411", "116411021", "story_v_out_116411.awb")

						arg_95_1:RecordAudio("116411021", var_98_11)
						arg_95_1:RecordAudio("116411021", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116411", "116411021", "story_v_out_116411.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116411", "116411021", "story_v_out_116411.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play116411022 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116411022
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116411023(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10025ui_story"]) and arg_99_1.var_.characterEffect10025ui_story == nil then
				arg_99_1.var_.characterEffect10025ui_story = arg_99_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10025ui_story"]) then
				if arg_99_1.var_.characterEffect10025ui_story and not isNil(arg_99_1.actors_["10025ui_story"]) then
					arg_99_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10025ui_story"]) and arg_99_1.var_.characterEffect10025ui_story then
				arg_99_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.275

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(116411022).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 11 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 11)

				if (11 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 11)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play116411023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116411023
		arg_103_1.duration_ = 14.3

		local var_103_0 = {
			zh = 12.566,
			ja = 14.3
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116411024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_0 = arg_103_1.bgs_.I05f

				arg_103_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_1 = var_106_0:GetComponent("SpriteRenderer")

				if var_106_1 and var_106_1.sprite then
					local var_106_2 = 2 * (var_106_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_0.transform.localScale = Vector3.New(var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "I05f" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_3 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_4 = 2

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_4 then
				local var_106_5 = Color.New(1, 1, 1)

				var_106_5.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_3) / var_106_4)
				arg_103_1.mask_.color = var_106_5
			end

			if arg_103_1.time_ >= var_106_3 + var_106_4 and arg_103_1.time_ < var_106_3 + var_106_4 + arg_106_0 then
				local var_106_6 = Color.New(1, 1, 1)

				var_106_6.a = 1
				arg_103_1.mask_.color = var_106_6
			end

			local var_106_7 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_8 = 2

			if var_106_7 <= arg_103_1.time_ and arg_103_1.time_ < var_106_7 + var_106_8 then
				local var_106_9 = Color.New(1, 1, 1)

				var_106_9.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_7) / var_106_8)
				arg_103_1.mask_.color = var_106_9
			end

			if arg_103_1.time_ >= var_106_7 + var_106_8 and arg_103_1.time_ < var_106_7 + var_106_8 + arg_106_0 then
				local var_106_10 = Color.New(1, 1, 1)

				arg_103_1.mask_.enabled = false
				var_106_10.a = 0
				arg_103_1.mask_.color = var_106_10
			end

			local var_106_11 = 0

			arg_103_1.isInRecall_ = false

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.screenFilterGo_:SetActive(false)

				for iter_106_2, iter_106_3 in pairs(arg_103_1.actors_) do
					for iter_106_4, iter_106_5 in ipairs((iter_106_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_106_5.color = iter_106_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_106_12 = 0.0166666666666667

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_12 then
				arg_103_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_11) / var_106_12)
			end

			if arg_103_1.time_ >= var_106_11 + var_106_12 and arg_103_1.time_ < var_106_11 + var_106_12 + arg_106_0 then
				arg_103_1.screenFilterEffect_.weight = 0
			end

			local var_106_13 = arg_103_1.actors_["10025ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10025ui_story = var_106_13.localPosition
			end

			local var_106_14 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_14 then
				var_106_13.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_14)
				var_106_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_13.position).x, (manager.ui.mainCamera.transform.position - var_106_13.position).y, (manager.ui.mainCamera.transform.position - var_106_13.position).z)
				var_106_13.localEulerAngles.z = 0
				var_106_13.localEulerAngles.x = 0
				var_106_13.localEulerAngles = var_106_13.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_14 and arg_103_1.time_ < 0 + var_106_14 + arg_106_0 then
				var_106_13.localPosition = Vector3.New(0, 100, 0)
				var_106_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_13.position).x, (manager.ui.mainCamera.transform.position - var_106_13.position).y, (manager.ui.mainCamera.transform.position - var_106_13.position).z)
				var_106_13.localEulerAngles.z = 0
				var_106_13.localEulerAngles.x = 0
				var_106_13.localEulerAngles = var_106_13.localEulerAngles
			end

			local var_106_15 = arg_103_1.actors_["10025ui_story"].transform

			if 3.80000000000001 < arg_103_1.time_ and arg_103_1.time_ <= 3.80000000000001 + arg_106_0 then
				arg_103_1.var_.moveOldPos10025ui_story = var_106_15.localPosition
			end

			local var_106_16 = 0.001

			if 3.80000000000001 <= arg_103_1.time_ and arg_103_1.time_ < 3.80000000000001 + var_106_16 then
				var_106_15.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_103_1.time_ - 3.80000000000001) / var_106_16)
				var_106_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_15.position).x, (manager.ui.mainCamera.transform.position - var_106_15.position).y, (manager.ui.mainCamera.transform.position - var_106_15.position).z)
				var_106_15.localEulerAngles.z = 0
				var_106_15.localEulerAngles.x = 0
				var_106_15.localEulerAngles = var_106_15.localEulerAngles
			end

			if arg_103_1.time_ >= 3.80000000000001 + var_106_16 and arg_103_1.time_ < 3.80000000000001 + var_106_16 + arg_106_0 then
				var_106_15.localPosition = Vector3.New(0, -1.1, -5.9)
				var_106_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_15.position).x, (manager.ui.mainCamera.transform.position - var_106_15.position).y, (manager.ui.mainCamera.transform.position - var_106_15.position).z)
				var_106_15.localEulerAngles.z = 0
				var_106_15.localEulerAngles.x = 0
				var_106_15.localEulerAngles = var_106_15.localEulerAngles
			end

			local var_106_17 = arg_103_1.actors_["10025ui_story"]

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 and not isNil(var_106_17) and arg_103_1.var_.characterEffect10025ui_story == nil then
				arg_103_1.var_.characterEffect10025ui_story = var_106_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_18 = 0.2

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_18 and not isNil(var_106_17) then
				if arg_103_1.var_.characterEffect10025ui_story and not isNil(var_106_17) then
					arg_103_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 3.8 + var_106_18 and arg_103_1.time_ < 3.8 + var_106_18 + arg_106_0 and not isNil(var_106_17) and arg_103_1.var_.characterEffect10025ui_story then
				arg_103_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_20 = 3.99999999999999
			local var_106_21 = 0.65

			if 3.99999999999999 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_22 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_22:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_23 = arg_103_1:GetWordFromCfg(116411023)
				local var_106_24 = arg_103_1:FormatText(var_106_23.content)

				arg_103_1.text_.text = var_106_24

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_26 = 26 <= 0 and var_106_21 or var_106_21 * (utf8.len(var_106_24) / 26)

				if (26 <= 0 and var_106_21 or var_106_21 * (utf8.len(var_106_24) / 26)) > 0 and var_106_21 < var_106_26 then
					arg_103_1.talkMaxDuration = var_106_26
					var_106_20 = var_106_20 + 0.3

					if var_106_26 + var_106_20 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_26 + var_106_20
					end
				end

				arg_103_1.text_.text = var_106_24
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411023", "story_v_out_116411.awb") ~= 0 then
					local var_106_27 = manager.audio:GetVoiceLength("story_v_out_116411", "116411023", "story_v_out_116411.awb") / 1000

					if var_106_27 + var_106_20 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_27 + var_106_20
					end

					if var_106_23.prefab_name ~= "" and arg_103_1.actors_[var_106_23.prefab_name] ~= nil then
						local var_106_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_23.prefab_name].transform, "story_v_out_116411", "116411023", "story_v_out_116411.awb")

						arg_103_1:RecordAudio("116411023", var_106_28)
						arg_103_1:RecordAudio("116411023", var_106_28)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116411", "116411023", "story_v_out_116411.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116411", "116411023", "story_v_out_116411.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_29 = var_106_20 + 0.3
			local var_106_30 = math.max(var_106_21, arg_103_1.talkMaxDuration)

			if var_106_20 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_29 + var_106_30 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_29) / var_106_30

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_29 + var_106_30 and arg_103_1.time_ < var_106_29 + var_106_30 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.80000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play116411024 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116411024
		arg_109_1.duration_ = 6.67

		local var_109_0 = {
			zh = 6.666,
			ja = 6.1
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
				arg_109_0:Play116411025(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10025ui_story = arg_109_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).z)
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles = arg_109_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_109_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10025ui_story"].transform.position).z)
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10025ui_story"].transform.localEulerAngles = arg_109_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10025ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10025ui_story == nil then
				arg_109_1.var_.characterEffect10025ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10025ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10025ui_story then
				arg_109_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(116411024)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)

				if (14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411024", "story_v_out_116411.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411024", "story_v_out_116411.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_116411", "116411024", "story_v_out_116411.awb")

						arg_109_1:RecordAudio("116411024", var_112_11)
						arg_109_1:RecordAudio("116411024", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_116411", "116411024", "story_v_out_116411.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_116411", "116411024", "story_v_out_116411.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play116411025 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116411025
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play116411026(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10025ui_story = arg_113_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).z)
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles = arg_113_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10025ui_story"].transform.position).z)
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10025ui_story"].transform.localEulerAngles = arg_113_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_116_1 = 0
			local var_116_2 = 0.9

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(116411025).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 36 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 36)

				if (36 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 36)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play116411026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116411026
		arg_117_1.duration_ = 9.1

		local var_117_0 = {
			zh = 8.966,
			ja = 9.1
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116411027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10025ui_story = arg_117_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).z)
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles = arg_117_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_117_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10025ui_story"].transform.position).z)
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10025ui_story"].transform.localEulerAngles = arg_117_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10025ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10025ui_story == nil then
				arg_117_1.var_.characterEffect10025ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10025ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10025ui_story then
				arg_117_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.55

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(116411026)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 22 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 22)

				if (22 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 22)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116411", "116411026", "story_v_out_116411.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_116411", "116411026", "story_v_out_116411.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_116411", "116411026", "story_v_out_116411.awb")

						arg_117_1:RecordAudio("116411026", var_120_11)
						arg_117_1:RecordAudio("116411026", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116411", "116411026", "story_v_out_116411.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116411", "116411026", "story_v_out_116411.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play116411027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116411027
		arg_121_1.duration_ = 6.23

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play116411028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10025ui_story = arg_121_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).z)
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles = arg_121_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10025ui_story"].transform.position).z)
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10025ui_story"].transform.localEulerAngles = arg_121_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.bgs_.I05f.transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPosI05f = var_124_1.localPosition
			end

			local var_124_2 = 3

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 then
				var_124_1.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPosI05f, Vector3.New(0.5, 1, 9), (arg_121_1.time_ - 0) / var_124_2)
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 then
				var_124_1.localPosition = Vector3.New(0.5, 1, 9)
			end

			local var_124_3 = manager.ui.mainCamera.transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_3.localPosition
			end

			local var_124_4 = 1.5

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				local var_124_5, var_124_6 = math.modf((arg_121_1.time_ - 0) / 0.066)

				var_124_3.localPosition = Vector3.New(var_124_6 * 0.13, var_124_6 * 0.13, var_124_6 * 0.13) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_7 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			if arg_121_1.time_ >= var_124_7 + 1.5 and arg_121_1.time_ < var_124_7 + 1.5 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_8 = 1.23333333333333
			local var_124_9 = 1.05

			if 1.23333333333333 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_10 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_10:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(116411027).content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 42 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 42)

				if (42 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 42)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13
					var_124_8 = var_124_8 + 0.3

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = var_124_8 + 0.3
			local var_124_15 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_14) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_14 + var_124_15 and arg_121_1.time_ < var_124_14 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "I05f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play116411028 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116411028
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116411029(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.65

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(116411028).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 26 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 26)

				if (26 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 26)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116411029 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116411029
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play116411030(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(116411029).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 25 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 25)

				if (25 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 25)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play116411030 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116411030
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116411031(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_138_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_2 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_2

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_2
						arg_135_1.bgmTxt2_.text = var_138_2
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_138_3 = 0
			local var_138_4 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116411030).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 22 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 22)

				if (22 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 22)) > 0 and var_138_4 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_8 and arg_135_1.time_ < var_138_3 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116411031 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 116411031
		arg_140_1.duration_ = 152.66

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
			arg_140_1.auto_ = false
		end

		function arg_140_1.playNext_(arg_142_0)
			arg_140_1.onStoryFinished_()
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 2 < arg_140_1.time_ and arg_140_1.time_ <= 2 + arg_143_0 then
				SetActive(arg_140_1.dialog_, false)
				SetActive(arg_140_1.allBtn_.gameObject, false)
				arg_140_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/101164101.usm", function(arg_144_0)
					arg_140_1:Skip(arg_144_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_145_0)
					arg_140_1.state_ = arg_145_0 and "pause" or "playing"
				end, 101164101)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_143_0 = 150.64

			if 2 <= arg_140_1.time_ and arg_140_1.time_ < 2 + var_143_0 then
				-- block empty
			end

			if arg_140_1.time_ >= 2 + var_143_0 and arg_140_1.time_ < 2 + var_143_0 + arg_143_0 then
				-- block empty
			end

			local var_143_1 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_2 = 2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = Color.New(0, 0, 0)

				var_143_3.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_1) / var_143_2)
				arg_140_1.mask_.color = var_143_3
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				local var_143_4 = Color.New(0, 0, 0)

				var_143_4.a = 1
				arg_140_1.mask_.color = var_143_4
			end

			local var_143_5 = 2

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_6 = 0.0166666666666667

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 then
				local var_143_7 = Color.New(0, 0, 0)

				var_143_7.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_5) / var_143_6)
				arg_140_1.mask_.color = var_143_7
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 then
				local var_143_8 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_8.a = 0
				arg_140_1.mask_.color = var_143_8
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/I05f",
		"TextureConfig/Background/I06",
		"TextureConfig/Background/ST03",
		"SofdecAsset/story/101164101.usm"
	},
	voices = {
		"story_v_out_116411.awb"
	}
}

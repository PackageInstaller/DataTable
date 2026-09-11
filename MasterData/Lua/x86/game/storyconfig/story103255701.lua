return {
	Play325571001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325571001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325571002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2006a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2006a")
				var_4_0.name = "ST2006a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2006a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2006a

				arg_1_1.bgs_.ST2006a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2006a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 1.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325571001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 45 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 45)

				if (45 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 45)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325571002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325571002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325571003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325571002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 56 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 56)

				if (56 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 56)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325571003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325571003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325571004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325571003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 47 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 47)

				if (47 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 47)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325571004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325571004
		arg_16_1.duration_ = 3.33

		local var_16_0 = {
			zh = 2.933,
			ja = 3.333
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325571005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["10167ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10167ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "10167ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10167ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["10167ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["10167ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["10167ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["10167ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10167ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.28, -5.73)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["10167ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10167ui_story == nil then
				arg_16_1.var_.characterEffect10167ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect10167ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10167ui_story then
				arg_16_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_10 = 0
			local var_19_11 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(325571004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 13 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 13)

				if (13 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 13)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571004", "story_v_out_325571.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_325571", "325571004", "story_v_out_325571.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_325571", "325571004", "story_v_out_325571.awb")

						arg_16_1:RecordAudio("325571004", var_19_17)
						arg_16_1:RecordAudio("325571004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325571", "325571004", "story_v_out_325571.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325571", "325571004", "story_v_out_325571.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325571005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325571005
		arg_20_1.duration_ = 4.17

		local var_20_0 = {
			zh = 2.733,
			ja = 4.166
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325571006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10167ui_story = arg_20_1.actors_["10167ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).z)
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles = arg_20_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_20_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10167ui_story"].transform.position).z)
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10167ui_story"].transform.localEulerAngles = arg_20_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = "10175ui_story"

			if arg_20_1.actors_["10175ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10175ui_story"))) then
				local var_23_4 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_20_1.stage_.transform)

				var_23_4.name = var_23_3
				var_23_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_3] = var_23_4

				local var_23_5 = var_23_4:GetComponentInChildren(typeof(CharacterEffect))

				var_23_5.enabled = true

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_4, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_5.transform, false)

				arg_20_1.var_[var_23_3 .. "Animator"] = var_23_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_3 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_3 .. "LipSync"] = var_23_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_7 = arg_20_1.actors_["10175ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10175ui_story = var_23_7.localPosition

				local var_23_8 = GameObjectTools.GetOrAddComponent(var_23_7.gameObject, typeof(DynamicBoneHelper))

				if var_23_8 then
					var_23_8:EnableDynamicBone(false)
				end
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_7.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_20_1.time_ - 0) / var_23_9)
				var_23_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_7.position).x, (manager.ui.mainCamera.transform.position - var_23_7.position).y, (manager.ui.mainCamera.transform.position - var_23_7.position).z)
				var_23_7.localEulerAngles.z = 0
				var_23_7.localEulerAngles.x = 0
				var_23_7.localEulerAngles = var_23_7.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_7.localPosition = Vector3.New(0.7, -1, -6.05)
				var_23_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_7.position).x, (manager.ui.mainCamera.transform.position - var_23_7.position).y, (manager.ui.mainCamera.transform.position - var_23_7.position).z)
				var_23_7.localEulerAngles.z = 0
				var_23_7.localEulerAngles.x = 0
				var_23_7.localEulerAngles = var_23_7.localEulerAngles

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_7.gameObject, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(true)
				end
			end

			local var_23_11 = arg_20_1.actors_["10175ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10175ui_story == nil then
				arg_20_1.var_.characterEffect10175ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_12 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_12 and not isNil(var_23_11) then
				if arg_20_1.var_.characterEffect10175ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_12 and arg_20_1.time_ < 0 + var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10175ui_story then
				arg_20_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_23_14 = arg_20_1.actors_["10167ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10167ui_story == nil then
				arg_20_1.var_.characterEffect10167ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_15 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_15 and not isNil(var_23_14) then
				if arg_20_1.var_.characterEffect10167ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_15)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_15 and arg_20_1.time_ < 0 + var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10167ui_story then
				arg_20_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_23_16 = 0
			local var_23_17 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(325571005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 19 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 19)

				if (19 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 19)) > 0 and var_23_17 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571005", "story_v_out_325571.awb") ~= 0 then
					local var_23_22 = manager.audio:GetVoiceLength("story_v_out_325571", "325571005", "story_v_out_325571.awb") / 1000

					if var_23_22 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_16
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_325571", "325571005", "story_v_out_325571.awb")

						arg_20_1:RecordAudio("325571005", var_23_23)
						arg_20_1:RecordAudio("325571005", var_23_23)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325571", "325571005", "story_v_out_325571.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325571", "325571005", "story_v_out_325571.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_24 and arg_20_1.time_ < var_23_16 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325571006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325571006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325571007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10175ui_story = arg_24_1.actors_["10175ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).z)
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles = arg_24_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10175ui_story"].transform.position).z)
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10175ui_story"].transform.localEulerAngles = arg_24_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["10167ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10167ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, 100, 0)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["10175ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect10175ui_story == nil then
				arg_24_1.var_.characterEffect10175ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect10175ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_8)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect10175ui_story then
				arg_24_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_27_9 = 0
			local var_27_10 = 0.975

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(325571006).content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 39 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 39)

				if (39 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 39)) > 0 and var_27_10 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_14 and arg_24_1.time_ < var_27_9 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play325571007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325571007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			zh = 8.566,
			ja = 5.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325571008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["10176ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10176ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "10176ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["10176ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["10176ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["10176ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["10176ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["10176ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10176ui_story = var_31_3.localPosition

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_28_1.time_ - 0) / var_31_5)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(true)
				end
			end

			local var_31_7 = arg_28_1.actors_["10176ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect10176ui_story == nil then
				arg_28_1.var_.characterEffect10176ui_story = var_31_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 and not isNil(var_31_7) then
				if arg_28_1.var_.characterEffect10176ui_story and not isNil(var_31_7) then
					arg_28_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect10176ui_story then
				arg_28_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_31_10 = 0
			local var_31_11 = 0.55

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(325571007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 22 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 22)

				if (22 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 22)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571007", "story_v_out_325571.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_325571", "325571007", "story_v_out_325571.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_325571", "325571007", "story_v_out_325571.awb")

						arg_28_1:RecordAudio("325571007", var_31_17)
						arg_28_1:RecordAudio("325571007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325571", "325571007", "story_v_out_325571.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325571", "325571007", "story_v_out_325571.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325571008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325571008
		arg_32_1.duration_ = 5.97

		local var_32_0 = {
			zh = 4.4,
			ja = 5.966
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325571009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10176ui_story = arg_32_1.actors_["10176ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10176ui_story, Vector3.New(-0.7, -1.09, -6.12), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).z)
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles = arg_32_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.12)
				arg_32_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10176ui_story"].transform.position).z)
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["10176ui_story"].transform.localEulerAngles = arg_32_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["10175ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10175ui_story = var_35_3.localPosition

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_32_1.time_ - 0) / var_35_5)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(true)
				end
			end

			local var_35_7 = arg_32_1.actors_["10175ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect10175ui_story == nil then
				arg_32_1.var_.characterEffect10175ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect10175ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect10175ui_story then
				arg_32_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_35_10 = arg_32_1.actors_["10176ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect10176ui_story == nil then
				arg_32_1.var_.characterEffect10176ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect10176ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect10176ui_story then
				arg_32_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_35_12 = 0
			local var_35_13 = 0.575

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(325571008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 23 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 23)

				if (23 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 23)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571008", "story_v_out_325571.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571008", "story_v_out_325571.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_325571", "325571008", "story_v_out_325571.awb")

						arg_32_1:RecordAudio("325571008", var_35_19)
						arg_32_1:RecordAudio("325571008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325571", "325571008", "story_v_out_325571.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325571", "325571008", "story_v_out_325571.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play325571009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325571009
		arg_36_1.duration_ = 6.6

		local var_36_0 = {
			zh = 6.233,
			ja = 6.6
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325571010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10175ui_story = arg_36_1.actors_["10175ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).z)
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles = arg_36_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10175ui_story"].transform.position).z)
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10175ui_story"].transform.localEulerAngles = arg_36_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["10176ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10176ui_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, 100, 0)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = arg_36_1.actors_["10167ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10167ui_story = var_39_7.localPosition

				local var_39_8 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_8 then
					var_39_8:EnableDynamicBone(false)
				end
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_7.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_36_1.time_ - 0) / var_39_9)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_7.localPosition = Vector3.New(0, -1.28, -5.73)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["10167ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10167ui_story == nil then
				arg_36_1.var_.characterEffect10167ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_12 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_12 and not isNil(var_39_11) then
				if arg_36_1.var_.characterEffect10167ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_12 and arg_36_1.time_ < 0 + var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10167ui_story then
				arg_36_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_39_14 = arg_36_1.actors_["10175ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10175ui_story == nil then
				arg_36_1.var_.characterEffect10175ui_story = var_39_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_15 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_15 and not isNil(var_39_14) then
				if arg_36_1.var_.characterEffect10175ui_story and not isNil(var_39_14) then
					arg_36_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_15)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_15 and arg_36_1.time_ < 0 + var_39_15 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10175ui_story then
				arg_36_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_39_16 = 0
			local var_39_17 = 0.625

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(325571009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 25 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 25)

				if (25 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 25)) > 0 and var_39_17 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21

					if var_39_21 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571009", "story_v_out_325571.awb") ~= 0 then
					local var_39_22 = manager.audio:GetVoiceLength("story_v_out_325571", "325571009", "story_v_out_325571.awb") / 1000

					if var_39_22 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_16
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_out_325571", "325571009", "story_v_out_325571.awb")

						arg_36_1:RecordAudio("325571009", var_39_23)
						arg_36_1:RecordAudio("325571009", var_39_23)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325571", "325571009", "story_v_out_325571.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325571", "325571009", "story_v_out_325571.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_24 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_24

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_24 and arg_36_1.time_ < var_39_16 + var_39_24 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325571010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325571010
		arg_40_1.duration_ = 11.93

		local var_40_0 = {
			zh = 11.033,
			ja = 11.933
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325571011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_43_0 = 0
			local var_43_1 = 1.15

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(325571010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 46 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 46)

				if (46 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 46)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571010", "story_v_out_325571.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571010", "story_v_out_325571.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_325571", "325571010", "story_v_out_325571.awb")

						arg_40_1:RecordAudio("325571010", var_43_7)
						arg_40_1:RecordAudio("325571010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325571", "325571010", "story_v_out_325571.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325571", "325571010", "story_v_out_325571.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325571011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325571011
		arg_44_1.duration_ = 8.4

		local var_44_0 = {
			zh = 8.4,
			ja = 7.866
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325571012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10167ui_story = arg_44_1.actors_["10167ui_story"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).z)
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles = arg_44_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_44_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10167ui_story"].transform.position).z)
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["10167ui_story"].transform.localEulerAngles = arg_44_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["10176ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10176ui_story = var_47_3.localPosition

				local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_4 then
					var_47_4:EnableDynamicBone(false)
				end
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10176ui_story, Vector3.New(0.79, -1.09, -6.12), (arg_44_1.time_ - 0) / var_47_5)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(0.79, -1.09, -6.12)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(true)
				end
			end

			local var_47_7 = arg_44_1.actors_["10176ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect10176ui_story == nil then
				arg_44_1.var_.characterEffect10176ui_story = var_47_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_8 and not isNil(var_47_7) then
				if arg_44_1.var_.characterEffect10176ui_story and not isNil(var_47_7) then
					arg_44_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_8 and arg_44_1.time_ < 0 + var_47_8 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.characterEffect10176ui_story then
				arg_44_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_47_10 = arg_44_1.actors_["10167ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect10167ui_story == nil then
				arg_44_1.var_.characterEffect10167ui_story = var_47_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_11 and not isNil(var_47_10) then
				if arg_44_1.var_.characterEffect10167ui_story and not isNil(var_47_10) then
					arg_44_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_11)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_11 and arg_44_1.time_ < 0 + var_47_11 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect10167ui_story then
				arg_44_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_47_12 = 0
			local var_47_13 = 0.65

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(325571011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 26 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 26)

				if (26 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 26)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571011", "story_v_out_325571.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571011", "story_v_out_325571.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_325571", "325571011", "story_v_out_325571.awb")

						arg_44_1:RecordAudio("325571011", var_47_19)
						arg_44_1:RecordAudio("325571011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325571", "325571011", "story_v_out_325571.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325571", "325571011", "story_v_out_325571.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325571012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325571012
		arg_48_1.duration_ = 8.77

		local var_48_0 = {
			zh = 7.8,
			ja = 8.766
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325571013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10167ui_story"]) and arg_48_1.var_.characterEffect10167ui_story == nil then
				arg_48_1.var_.characterEffect10167ui_story = arg_48_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10167ui_story"]) then
				if arg_48_1.var_.characterEffect10167ui_story and not isNil(arg_48_1.actors_["10167ui_story"]) then
					arg_48_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10167ui_story"]) and arg_48_1.var_.characterEffect10167ui_story then
				arg_48_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["10176ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10176ui_story == nil then
				arg_48_1.var_.characterEffect10176ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect10176ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10176ui_story then
				arg_48_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_51_4 = 0
			local var_51_5 = 0.775

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(325571012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 31 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 31)

				if (31 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 31)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571012", "story_v_out_325571.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571012", "story_v_out_325571.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_325571", "325571012", "story_v_out_325571.awb")

						arg_48_1:RecordAudio("325571012", var_51_11)
						arg_48_1:RecordAudio("325571012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325571", "325571012", "story_v_out_325571.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325571", "325571012", "story_v_out_325571.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325571013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325571013
		arg_52_1.duration_ = 6.37

		local var_52_0 = {
			zh = 6.366,
			ja = 5.633
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325571015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10176ui_story"]) and arg_52_1.var_.characterEffect10176ui_story == nil then
				arg_52_1.var_.characterEffect10176ui_story = arg_52_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10176ui_story"]) then
				if arg_52_1.var_.characterEffect10176ui_story and not isNil(arg_52_1.actors_["10176ui_story"]) then
					arg_52_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10176ui_story"]) and arg_52_1.var_.characterEffect10176ui_story then
				arg_52_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10167ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10167ui_story == nil then
				arg_52_1.var_.characterEffect10167ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect10167ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10167ui_story then
				arg_52_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.575

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(325571013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 23 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 23)

				if (23 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 23)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571013", "story_v_out_325571.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571013", "story_v_out_325571.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_325571", "325571013", "story_v_out_325571.awb")

						arg_52_1:RecordAudio("325571013", var_55_11)
						arg_52_1:RecordAudio("325571013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325571", "325571013", "story_v_out_325571.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325571", "325571013", "story_v_out_325571.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325571015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325571015
		arg_56_1.duration_ = 5.7

		local var_56_0 = {
			zh = 4.9,
			ja = 5.7
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325571016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10176ui_story = arg_56_1.actors_["10176ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).z)
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles = arg_56_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10176ui_story"].transform.position).z)
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10176ui_story"].transform.localEulerAngles = arg_56_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["10175ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10175ui_story = var_59_3.localPosition

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_56_1.time_ - 0) / var_59_5)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(true)
				end
			end

			local var_59_7 = arg_56_1.actors_["10175ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10175ui_story == nil then
				arg_56_1.var_.characterEffect10175ui_story = var_59_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_8 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_8 and not isNil(var_59_7) then
				if arg_56_1.var_.characterEffect10175ui_story and not isNil(var_59_7) then
					arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_8 and arg_56_1.time_ < 0 + var_59_8 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10175ui_story then
				arg_56_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_59_10 = arg_56_1.actors_["10176ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect10176ui_story == nil then
				arg_56_1.var_.characterEffect10176ui_story = var_59_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_11 and not isNil(var_59_10) then
				if arg_56_1.var_.characterEffect10176ui_story and not isNil(var_59_10) then
					arg_56_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_11)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_11 and arg_56_1.time_ < 0 + var_59_11 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect10176ui_story then
				arg_56_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_59_12 = 0
			local var_59_13 = 0.55

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(325571015)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 22 <= 0 and var_59_13 or var_59_13 * (utf8.len(var_59_15) / 22)

				if (22 <= 0 and var_59_13 or var_59_13 * (utf8.len(var_59_15) / 22)) > 0 and var_59_13 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571015", "story_v_out_325571.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571015", "story_v_out_325571.awb") / 1000

					if var_59_18 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_12
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_325571", "325571015", "story_v_out_325571.awb")

						arg_56_1:RecordAudio("325571015", var_59_19)
						arg_56_1:RecordAudio("325571015", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325571", "325571015", "story_v_out_325571.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325571", "325571015", "story_v_out_325571.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_20 and arg_56_1.time_ < var_59_12 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325571016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325571016
		arg_60_1.duration_ = 6.9

		local var_60_0 = {
			zh = 6,
			ja = 6.9
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325571017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.75

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(325571016)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 30)

				if (30 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 30)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571016", "story_v_out_325571.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571016", "story_v_out_325571.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_325571", "325571016", "story_v_out_325571.awb")

						arg_60_1:RecordAudio("325571016", var_63_6)
						arg_60_1:RecordAudio("325571016", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325571", "325571016", "story_v_out_325571.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325571", "325571016", "story_v_out_325571.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325571017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325571017
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325571018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) and arg_64_1.var_.characterEffect10175ui_story == nil then
				arg_64_1.var_.characterEffect10175ui_story = arg_64_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) then
				if arg_64_1.var_.characterEffect10175ui_story and not isNil(arg_64_1.actors_["10175ui_story"]) then
					arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10175ui_story"]) and arg_64_1.var_.characterEffect10175ui_story then
				arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 1.375

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(325571017).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 55 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 55)

				if (55 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 55)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325571018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325571018
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325571019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.05

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(325571018).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 42 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 42)

				if (42 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 42)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325571019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325571019
		arg_72_1.duration_ = 7.67

		local var_72_0 = {
			zh = 7.666,
			ja = 4.533
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325571020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10175ui_story = arg_72_1.actors_["10175ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).z)
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles = arg_72_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10175ui_story"].transform.position).z)
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10175ui_story"].transform.localEulerAngles = arg_72_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["10176ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10176ui_story = var_75_3.localPosition

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(false)
				end
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10176ui_story, Vector3.New(0.79, -1.09, -6.12), (arg_72_1.time_ - 0) / var_75_5)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0.79, -1.09, -6.12)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles

				local var_75_6 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_6 then
					var_75_6:EnableDynamicBone(true)
				end
			end

			local var_75_7 = arg_72_1.actors_["10176ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect10176ui_story == nil then
				arg_72_1.var_.characterEffect10176ui_story = var_75_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_8 and not isNil(var_75_7) then
				if arg_72_1.var_.characterEffect10176ui_story and not isNil(var_75_7) then
					arg_72_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_8 and arg_72_1.time_ < 0 + var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect10176ui_story then
				arg_72_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_10 = 0
			local var_75_11 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_12 = arg_72_1:GetWordFromCfg(325571019)
				local var_75_13 = arg_72_1:FormatText(var_75_12.content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_15 = 22 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 22)

				if (22 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 22)) > 0 and var_75_11 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_10 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_10
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571019", "story_v_out_325571.awb") ~= 0 then
					local var_75_16 = manager.audio:GetVoiceLength("story_v_out_325571", "325571019", "story_v_out_325571.awb") / 1000

					if var_75_16 + var_75_10 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_10
					end

					if var_75_12.prefab_name ~= "" and arg_72_1.actors_[var_75_12.prefab_name] ~= nil then
						local var_75_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_12.prefab_name].transform, "story_v_out_325571", "325571019", "story_v_out_325571.awb")

						arg_72_1:RecordAudio("325571019", var_75_17)
						arg_72_1:RecordAudio("325571019", var_75_17)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325571", "325571019", "story_v_out_325571.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325571", "325571019", "story_v_out_325571.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_18 = math.max(var_75_11, arg_72_1.talkMaxDuration)

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_10) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_10 + var_75_18 and arg_72_1.time_ < var_75_10 + var_75_18 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play325571020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325571020
		arg_76_1.duration_ = 4.57

		local var_76_0 = {
			zh = 4.466,
			ja = 4.566
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325571021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.475

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(325571020)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 19 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 19)

				if (19 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 19)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571020", "story_v_out_325571.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571020", "story_v_out_325571.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_325571", "325571020", "story_v_out_325571.awb")

						arg_76_1:RecordAudio("325571020", var_79_6)
						arg_76_1:RecordAudio("325571020", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325571", "325571020", "story_v_out_325571.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325571", "325571020", "story_v_out_325571.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325571021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325571021
		arg_80_1.duration_ = 6.57

		local var_80_0 = {
			zh = 4.933,
			ja = 6.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325571022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10167ui_story"]) and arg_80_1.var_.characterEffect10167ui_story == nil then
				arg_80_1.var_.characterEffect10167ui_story = arg_80_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10167ui_story"]) then
				if arg_80_1.var_.characterEffect10167ui_story and not isNil(arg_80_1.actors_["10167ui_story"]) then
					arg_80_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10167ui_story"]) and arg_80_1.var_.characterEffect10167ui_story then
				arg_80_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["10176ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect10176ui_story == nil then
				arg_80_1.var_.characterEffect10176ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect10176ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect10176ui_story then
				arg_80_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_83_4 = 0
			local var_83_5 = 0.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(325571021)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 22 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 22)

				if (22 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 22)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571021", "story_v_out_325571.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571021", "story_v_out_325571.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_325571", "325571021", "story_v_out_325571.awb")

						arg_80_1:RecordAudio("325571021", var_83_11)
						arg_80_1:RecordAudio("325571021", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325571", "325571021", "story_v_out_325571.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325571", "325571021", "story_v_out_325571.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325571022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325571022
		arg_84_1.duration_ = 4.67

		local var_84_0 = {
			zh = 4.666,
			ja = 4.266
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325571023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10176ui_story"]) and arg_84_1.var_.characterEffect10176ui_story == nil then
				arg_84_1.var_.characterEffect10176ui_story = arg_84_1.actors_["10176ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10176ui_story"]) then
				if arg_84_1.var_.characterEffect10176ui_story and not isNil(arg_84_1.actors_["10176ui_story"]) then
					arg_84_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10176ui_story"]) and arg_84_1.var_.characterEffect10176ui_story then
				arg_84_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["10167ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect10167ui_story == nil then
				arg_84_1.var_.characterEffect10167ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect10167ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect10167ui_story then
				arg_84_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_87_4 = 0
			local var_87_5 = 0.5

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(325571022)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 20 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 20)

				if (20 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 20)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571022", "story_v_out_325571.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571022", "story_v_out_325571.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_325571", "325571022", "story_v_out_325571.awb")

						arg_84_1:RecordAudio("325571022", var_87_11)
						arg_84_1:RecordAudio("325571022", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325571", "325571022", "story_v_out_325571.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325571", "325571022", "story_v_out_325571.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325571023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325571023
		arg_88_1.duration_ = 10.03

		local var_88_0 = {
			zh = 7.033,
			ja = 10.033
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325571024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10167ui_story"]) and arg_88_1.var_.characterEffect10167ui_story == nil then
				arg_88_1.var_.characterEffect10167ui_story = arg_88_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10167ui_story"]) then
				if arg_88_1.var_.characterEffect10167ui_story and not isNil(arg_88_1.actors_["10167ui_story"]) then
					arg_88_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10167ui_story"]) and arg_88_1.var_.characterEffect10167ui_story then
				arg_88_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["10176ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect10176ui_story == nil then
				arg_88_1.var_.characterEffect10176ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect10176ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect10176ui_story then
				arg_88_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_91_4 = 0
			local var_91_5 = 0.825

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(325571023)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 33 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 33)

				if (33 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 33)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571023", "story_v_out_325571.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571023", "story_v_out_325571.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_325571", "325571023", "story_v_out_325571.awb")

						arg_88_1:RecordAudio("325571023", var_91_11)
						arg_88_1:RecordAudio("325571023", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325571", "325571023", "story_v_out_325571.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325571", "325571023", "story_v_out_325571.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325571024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325571024
		arg_92_1.duration_ = 3

		local var_92_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325571025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10176ui_story = arg_92_1.actors_["10176ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).z)
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles = arg_92_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10176ui_story"].transform.position).z)
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10176ui_story"].transform.localEulerAngles = arg_92_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["10175ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10175ui_story = var_95_3.localPosition

				local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_3.gameObject, typeof(DynamicBoneHelper))

				if var_95_4 then
					var_95_4:EnableDynamicBone(false)
				end
			end

			local var_95_5 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_92_1.time_ - 0) / var_95_5)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles

				local var_95_6 = GameObjectTools.GetOrAddComponent(var_95_3.gameObject, typeof(DynamicBoneHelper))

				if var_95_6 then
					var_95_6:EnableDynamicBone(true)
				end
			end

			local var_95_7 = arg_92_1.actors_["10175ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.characterEffect10175ui_story == nil then
				arg_92_1.var_.characterEffect10175ui_story = var_95_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_8 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_8 and not isNil(var_95_7) then
				if arg_92_1.var_.characterEffect10175ui_story and not isNil(var_95_7) then
					arg_92_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_8 and arg_92_1.time_ < 0 + var_95_8 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.characterEffect10175ui_story then
				arg_92_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_95_10 = arg_92_1.actors_["10167ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_10) and arg_92_1.var_.characterEffect10167ui_story == nil then
				arg_92_1.var_.characterEffect10167ui_story = var_95_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_11 and not isNil(var_95_10) then
				if arg_92_1.var_.characterEffect10167ui_story and not isNil(var_95_10) then
					arg_92_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_11)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_11 and arg_92_1.time_ < 0 + var_95_11 + arg_95_0 and not isNil(var_95_10) and arg_92_1.var_.characterEffect10167ui_story then
				arg_92_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_95_12 = 0
			local var_95_13 = 0.25

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(325571024)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 10 <= 0 and var_95_13 or var_95_13 * (utf8.len(var_95_15) / 10)

				if (10 <= 0 and var_95_13 or var_95_13 * (utf8.len(var_95_15) / 10)) > 0 and var_95_13 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17

					if var_95_17 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571024", "story_v_out_325571.awb") ~= 0 then
					local var_95_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571024", "story_v_out_325571.awb") / 1000

					if var_95_18 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_12
					end

					if var_95_14.prefab_name ~= "" and arg_92_1.actors_[var_95_14.prefab_name] ~= nil then
						local var_95_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_14.prefab_name].transform, "story_v_out_325571", "325571024", "story_v_out_325571.awb")

						arg_92_1:RecordAudio("325571024", var_95_19)
						arg_92_1:RecordAudio("325571024", var_95_19)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325571", "325571024", "story_v_out_325571.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325571", "325571024", "story_v_out_325571.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_20 and arg_92_1.time_ < var_95_12 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play325571025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325571025
		arg_96_1.duration_ = 7.5

		local var_96_0 = {
			zh = 7.5,
			ja = 7.4
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325571026(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.925

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:GetWordFromCfg(325571025)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 37 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 37)

				if (37 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 37)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571025", "story_v_out_325571.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571025", "story_v_out_325571.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_325571", "325571025", "story_v_out_325571.awb")

						arg_96_1:RecordAudio("325571025", var_99_6)
						arg_96_1:RecordAudio("325571025", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325571", "325571025", "story_v_out_325571.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325571", "325571025", "story_v_out_325571.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325571026 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325571026
		arg_100_1.duration_ = 14.4

		local var_100_0 = {
			zh = 8.733,
			ja = 14.4
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325571027(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action5_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_103_0 = 0
			local var_103_1 = 1.025

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(325571026)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 41 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 41)

				if (41 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 41)) > 0 and var_103_1 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571026", "story_v_out_325571.awb") ~= 0 then
					local var_103_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571026", "story_v_out_325571.awb") / 1000

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end

					if var_103_2.prefab_name ~= "" and arg_100_1.actors_[var_103_2.prefab_name] ~= nil then
						local var_103_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_2.prefab_name].transform, "story_v_out_325571", "325571026", "story_v_out_325571.awb")

						arg_100_1:RecordAudio("325571026", var_103_7)
						arg_100_1:RecordAudio("325571026", var_103_7)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325571", "325571026", "story_v_out_325571.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325571", "325571026", "story_v_out_325571.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325571027 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325571027
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325571028(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10175ui_story"]) and arg_104_1.var_.characterEffect10175ui_story == nil then
				arg_104_1.var_.characterEffect10175ui_story = arg_104_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10175ui_story"]) then
				if arg_104_1.var_.characterEffect10175ui_story and not isNil(arg_104_1.actors_["10175ui_story"]) then
					arg_104_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10175ui_story"]) and arg_104_1.var_.characterEffect10175ui_story then
				arg_104_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 1.05

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(325571027).content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 42 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 42)

				if (42 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 42)) > 0 and var_107_2 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_6 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_6 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_6

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_6 and arg_104_1.time_ < var_107_1 + var_107_6 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325571028 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325571028
		arg_108_1.duration_ = 10.97

		local var_108_0 = {
			zh = 6.5,
			ja = 10.966
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325571029(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10175ui_story"]) and arg_108_1.var_.characterEffect10175ui_story == nil then
				arg_108_1.var_.characterEffect10175ui_story = arg_108_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10175ui_story"]) then
				if arg_108_1.var_.characterEffect10175ui_story and not isNil(arg_108_1.actors_["10175ui_story"]) then
					arg_108_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10175ui_story"]) and arg_108_1.var_.characterEffect10175ui_story then
				arg_108_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action5_2")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_111_2 = 0
			local var_111_3 = 0.775

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(325571028)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 31 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 31)

				if (31 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 31)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571028", "story_v_out_325571.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571028", "story_v_out_325571.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_325571", "325571028", "story_v_out_325571.awb")

						arg_108_1:RecordAudio("325571028", var_111_9)
						arg_108_1:RecordAudio("325571028", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325571", "325571028", "story_v_out_325571.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325571", "325571028", "story_v_out_325571.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325571029 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325571029
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325571030(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10167ui_story"]) and arg_112_1.var_.characterEffect10167ui_story == nil then
				arg_112_1.var_.characterEffect10167ui_story = arg_112_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10167ui_story"]) then
				if arg_112_1.var_.characterEffect10167ui_story and not isNil(arg_112_1.actors_["10167ui_story"]) then
					arg_112_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10167ui_story"]) and arg_112_1.var_.characterEffect10167ui_story then
				arg_112_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["10175ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect10175ui_story == nil then
				arg_112_1.var_.characterEffect10175ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect10175ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect10175ui_story then
				arg_112_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_115_4 = 0
			local var_115_5 = 0.075

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(325571029)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 3 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 3)

				if (3 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 3)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571029", "story_v_out_325571.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571029", "story_v_out_325571.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_325571", "325571029", "story_v_out_325571.awb")

						arg_112_1:RecordAudio("325571029", var_115_11)
						arg_112_1:RecordAudio("325571029", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325571", "325571029", "story_v_out_325571.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325571", "325571029", "story_v_out_325571.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325571030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325571030
		arg_116_1.duration_ = 7.67

		local var_116_0 = {
			zh = 5.3,
			ja = 7.666
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325571031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10175ui_story"]) and arg_116_1.var_.characterEffect10175ui_story == nil then
				arg_116_1.var_.characterEffect10175ui_story = arg_116_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10175ui_story"]) then
				if arg_116_1.var_.characterEffect10175ui_story and not isNil(arg_116_1.actors_["10175ui_story"]) then
					arg_116_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10175ui_story"]) and arg_116_1.var_.characterEffect10175ui_story then
				arg_116_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_119_2 = arg_116_1.actors_["10167ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect10167ui_story == nil then
				arg_116_1.var_.characterEffect10167ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect10167ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect10167ui_story then
				arg_116_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.625

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(325571030)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)

				if (25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571030", "story_v_out_325571.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571030", "story_v_out_325571.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_325571", "325571030", "story_v_out_325571.awb")

						arg_116_1:RecordAudio("325571030", var_119_11)
						arg_116_1:RecordAudio("325571030", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325571", "325571030", "story_v_out_325571.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325571", "325571030", "story_v_out_325571.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play325571031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325571031
		arg_120_1.duration_ = 15.53

		local var_120_0 = {
			zh = 9.7,
			ja = 15.533
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325571032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.075

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(325571031)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)

				if (43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571031", "story_v_out_325571.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571031", "story_v_out_325571.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_325571", "325571031", "story_v_out_325571.awb")

						arg_120_1:RecordAudio("325571031", var_123_6)
						arg_120_1:RecordAudio("325571031", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325571", "325571031", "story_v_out_325571.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325571", "325571031", "story_v_out_325571.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325571032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325571032
		arg_124_1.duration_ = 2

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325571033(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10167ui_story"]) and arg_124_1.var_.characterEffect10167ui_story == nil then
				arg_124_1.var_.characterEffect10167ui_story = arg_124_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10167ui_story"]) then
				if arg_124_1.var_.characterEffect10167ui_story and not isNil(arg_124_1.actors_["10167ui_story"]) then
					arg_124_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10167ui_story"]) and arg_124_1.var_.characterEffect10167ui_story then
				arg_124_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["10175ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect10175ui_story == nil then
				arg_124_1.var_.characterEffect10175ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_3 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.characterEffect10175ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_3)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect10175ui_story then
				arg_124_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_2")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_127_4 = 0
			local var_127_5 = 0.05

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(325571032)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 2 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 2)

				if (2 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 2)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571032", "story_v_out_325571.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571032", "story_v_out_325571.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_325571", "325571032", "story_v_out_325571.awb")

						arg_124_1:RecordAudio("325571032", var_127_11)
						arg_124_1:RecordAudio("325571032", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325571", "325571032", "story_v_out_325571.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325571", "325571032", "story_v_out_325571.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325571033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325571033
		arg_128_1.duration_ = 8.53

		local var_128_0 = {
			zh = 7.6,
			ja = 8.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325571034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10175ui_story"]) and arg_128_1.var_.characterEffect10175ui_story == nil then
				arg_128_1.var_.characterEffect10175ui_story = arg_128_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10175ui_story"]) then
				if arg_128_1.var_.characterEffect10175ui_story and not isNil(arg_128_1.actors_["10175ui_story"]) then
					arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10175ui_story"]) and arg_128_1.var_.characterEffect10175ui_story then
				arg_128_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["10167ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect10167ui_story == nil then
				arg_128_1.var_.characterEffect10167ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect10167ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect10167ui_story then
				arg_128_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175actionlink/10175action4392")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.9

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(325571033)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 36 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 36)

				if (36 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 36)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571033", "story_v_out_325571.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571033", "story_v_out_325571.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_325571", "325571033", "story_v_out_325571.awb")

						arg_128_1:RecordAudio("325571033", var_131_11)
						arg_128_1:RecordAudio("325571033", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325571", "325571033", "story_v_out_325571.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325571", "325571033", "story_v_out_325571.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325571034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325571034
		arg_132_1.duration_ = 7.53

		local var_132_0 = {
			zh = 4.4,
			ja = 7.533
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325571035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.575

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(325571034)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 23 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 23)

				if (23 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 23)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571034", "story_v_out_325571.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571034", "story_v_out_325571.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_325571", "325571034", "story_v_out_325571.awb")

						arg_132_1:RecordAudio("325571034", var_135_6)
						arg_132_1:RecordAudio("325571034", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325571", "325571034", "story_v_out_325571.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325571", "325571034", "story_v_out_325571.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325571035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325571035
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325571036(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10175ui_story"]) and arg_136_1.var_.characterEffect10175ui_story == nil then
				arg_136_1.var_.characterEffect10175ui_story = arg_136_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10175ui_story"]) then
				if arg_136_1.var_.characterEffect10175ui_story and not isNil(arg_136_1.actors_["10175ui_story"]) then
					arg_136_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10175ui_story"]) and arg_136_1.var_.characterEffect10175ui_story then
				arg_136_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_139_1 = 0
			local var_139_2 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(325571035).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 38 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 38)

				if (38 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 38)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325571036 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325571036
		arg_140_1.duration_ = 4.63

		local var_140_0 = {
			zh = 4.3,
			ja = 4.633
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325571037(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10167ui_story"]) and arg_140_1.var_.characterEffect10167ui_story == nil then
				arg_140_1.var_.characterEffect10167ui_story = arg_140_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10167ui_story"]) then
				if arg_140_1.var_.characterEffect10167ui_story and not isNil(arg_140_1.actors_["10167ui_story"]) then
					arg_140_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10167ui_story"]) and arg_140_1.var_.characterEffect10167ui_story then
				arg_140_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0
			local var_143_3 = 0.35

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(325571036)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 14 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 14)

				if (14 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 14)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571036", "story_v_out_325571.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_325571", "325571036", "story_v_out_325571.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_325571", "325571036", "story_v_out_325571.awb")

						arg_140_1:RecordAudio("325571036", var_143_9)
						arg_140_1:RecordAudio("325571036", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325571", "325571036", "story_v_out_325571.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325571", "325571036", "story_v_out_325571.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325571037 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325571037
		arg_144_1.duration_ = 9.17

		local var_144_0 = {
			zh = 6.7,
			ja = 9.166
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325571038(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.675

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(325571037)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 27 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 27)

				if (27 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 27)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571037", "story_v_out_325571.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571037", "story_v_out_325571.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_325571", "325571037", "story_v_out_325571.awb")

						arg_144_1:RecordAudio("325571037", var_147_6)
						arg_144_1:RecordAudio("325571037", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325571", "325571037", "story_v_out_325571.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325571", "325571037", "story_v_out_325571.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325571038 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325571038
		arg_148_1.duration_ = 9.47

		local var_148_0 = {
			zh = 7.733,
			ja = 9.466
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325571039(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10175ui_story"]) and arg_148_1.var_.characterEffect10175ui_story == nil then
				arg_148_1.var_.characterEffect10175ui_story = arg_148_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10175ui_story"]) then
				if arg_148_1.var_.characterEffect10175ui_story and not isNil(arg_148_1.actors_["10175ui_story"]) then
					arg_148_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10175ui_story"]) and arg_148_1.var_.characterEffect10175ui_story then
				arg_148_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["10167ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect10167ui_story == nil then
				arg_148_1.var_.characterEffect10167ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_3 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.characterEffect10167ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_3)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect10167ui_story then
				arg_148_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_151_4 = 0
			local var_151_5 = 0.875

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(325571038)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 35 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 35)

				if (35 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 35)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571038", "story_v_out_325571.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_325571", "325571038", "story_v_out_325571.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_325571", "325571038", "story_v_out_325571.awb")

						arg_148_1:RecordAudio("325571038", var_151_11)
						arg_148_1:RecordAudio("325571038", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325571", "325571038", "story_v_out_325571.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325571", "325571038", "story_v_out_325571.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325571039 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325571039
		arg_152_1.duration_ = 6.87

		local var_152_0 = {
			zh = 5.9,
			ja = 6.866
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325571040(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10175ui_story = arg_152_1.actors_["10175ui_story"].transform.localPosition

				local var_155_0 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_0 then
					var_155_0:EnableDynamicBone(false)
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_1)
				arg_152_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).z)
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles = arg_152_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10175ui_story"].transform.position).z)
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10175ui_story"].transform.localEulerAngles = arg_152_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_155_2 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(true)
				end
			end

			local var_155_3 = arg_152_1.actors_["10176ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10176ui_story = var_155_3.localPosition

				local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_4 then
					var_155_4:EnableDynamicBone(false)
				end
			end

			local var_155_5 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				var_155_3.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10176ui_story, Vector3.New(0.79, -1.09, -6.12), (arg_152_1.time_ - 0) / var_155_5)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				var_155_3.localPosition = Vector3.New(0.79, -1.09, -6.12)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles

				local var_155_6 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_6 then
					var_155_6:EnableDynamicBone(true)
				end
			end

			local var_155_7 = arg_152_1.actors_["10176ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect10176ui_story == nil then
				arg_152_1.var_.characterEffect10176ui_story = var_155_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_8 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_8 and not isNil(var_155_7) then
				if arg_152_1.var_.characterEffect10176ui_story and not isNil(var_155_7) then
					arg_152_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_8 and arg_152_1.time_ < 0 + var_155_8 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect10176ui_story then
				arg_152_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_155_10 = arg_152_1.actors_["10175ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_10) and arg_152_1.var_.characterEffect10175ui_story == nil then
				arg_152_1.var_.characterEffect10175ui_story = var_155_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_11 and not isNil(var_155_10) then
				if arg_152_1.var_.characterEffect10175ui_story and not isNil(var_155_10) then
					arg_152_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_11)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_11 and arg_152_1.time_ < 0 + var_155_11 + arg_155_0 and not isNil(var_155_10) and arg_152_1.var_.characterEffect10175ui_story then
				arg_152_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_155_12 = 0
			local var_155_13 = 0.5

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_14 = arg_152_1:GetWordFromCfg(325571039)
				local var_155_15 = arg_152_1:FormatText(var_155_14.content)

				arg_152_1.text_.text = var_155_15

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 20 <= 0 and var_155_13 or var_155_13 * (utf8.len(var_155_15) / 20)

				if (20 <= 0 and var_155_13 or var_155_13 * (utf8.len(var_155_15) / 20)) > 0 and var_155_13 < var_155_17 then
					arg_152_1.talkMaxDuration = var_155_17

					if var_155_17 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_17 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_15
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571039", "story_v_out_325571.awb") ~= 0 then
					local var_155_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571039", "story_v_out_325571.awb") / 1000

					if var_155_18 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_18 + var_155_12
					end

					if var_155_14.prefab_name ~= "" and arg_152_1.actors_[var_155_14.prefab_name] ~= nil then
						local var_155_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_14.prefab_name].transform, "story_v_out_325571", "325571039", "story_v_out_325571.awb")

						arg_152_1:RecordAudio("325571039", var_155_19)
						arg_152_1:RecordAudio("325571039", var_155_19)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325571", "325571039", "story_v_out_325571.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325571", "325571039", "story_v_out_325571.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_20 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_20 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_20

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_20 and arg_152_1.time_ < var_155_12 + var_155_20 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play325571040 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325571040
		arg_156_1.duration_ = 7.3

		local var_156_0 = {
			zh = 7.3,
			ja = 6.4
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325571041(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176actionlink/10176action445")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_159_0 = 0
			local var_159_1 = 0.6

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(325571040)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 24 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 24)

				if (24 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 24)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571040", "story_v_out_325571.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571040", "story_v_out_325571.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_325571", "325571040", "story_v_out_325571.awb")

						arg_156_1:RecordAudio("325571040", var_159_7)
						arg_156_1:RecordAudio("325571040", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325571", "325571040", "story_v_out_325571.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325571", "325571040", "story_v_out_325571.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325571041 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325571041
		arg_160_1.duration_ = 8.03

		local var_160_0 = {
			zh = 8.03199999815225,
			ja = 7.56599999815226
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325571042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.J21h == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_163_0.name = "J21h"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.J21h = var_163_0
			end

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.J21h

				arg_160_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "J21h" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 3.999999999999

			if 3.999999999999 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_4 + 0.3 and arg_160_1.time_ < var_163_4 + 0.3 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_5 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_6 = 2

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_5) / var_163_6)
				arg_160_1.mask_.color = var_163_7
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 then
				local var_163_8 = Color.New(0, 0, 0)

				var_163_8.a = 1
				arg_160_1.mask_.color = var_163_8
			end

			local var_163_9 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_10 = 2

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 then
				local var_163_11 = Color.New(0, 0, 0)

				var_163_11.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_9) / var_163_10)
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 then
				local var_163_12 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_12.a = 0
				arg_160_1.mask_.color = var_163_12
			end

			local var_163_13 = arg_160_1.actors_["10176ui_story"].transform

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 then
				arg_160_1.var_.moveOldPos10176ui_story = var_163_13.localPosition

				local var_163_14 = GameObjectTools.GetOrAddComponent(var_163_13.gameObject, typeof(DynamicBoneHelper))

				if var_163_14 then
					var_163_14:EnableDynamicBone(false)
				end
			end

			local var_163_15 = 0.001

			if 1.96599999815226 <= arg_160_1.time_ and arg_160_1.time_ < 1.96599999815226 + var_163_15 then
				var_163_13.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 1.96599999815226) / var_163_15)
				var_163_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_13.position).x, (manager.ui.mainCamera.transform.position - var_163_13.position).y, (manager.ui.mainCamera.transform.position - var_163_13.position).z)
				var_163_13.localEulerAngles.z = 0
				var_163_13.localEulerAngles.x = 0
				var_163_13.localEulerAngles = var_163_13.localEulerAngles
			end

			if arg_160_1.time_ >= 1.96599999815226 + var_163_15 and arg_160_1.time_ < 1.96599999815226 + var_163_15 + arg_163_0 then
				var_163_13.localPosition = Vector3.New(0, 100, 0)
				var_163_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_13.position).x, (manager.ui.mainCamera.transform.position - var_163_13.position).y, (manager.ui.mainCamera.transform.position - var_163_13.position).z)
				var_163_13.localEulerAngles.z = 0
				var_163_13.localEulerAngles.x = 0
				var_163_13.localEulerAngles = var_163_13.localEulerAngles

				local var_163_16 = GameObjectTools.GetOrAddComponent(var_163_13.gameObject, typeof(DynamicBoneHelper))

				if var_163_16 then
					var_163_16:EnableDynamicBone(true)
				end
			end

			local var_163_17 = "10166ui_story"

			if arg_160_1.actors_["10166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10166ui_story"))) then
				local var_163_18 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_160_1.stage_.transform)

				var_163_18.name = var_163_17
				var_163_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_[var_163_17] = var_163_18

				local var_163_19 = var_163_18:GetComponentInChildren(typeof(CharacterEffect))

				var_163_19.enabled = true

				local var_163_20 = GameObjectTools.GetOrAddComponent(var_163_18, typeof(DynamicBoneHelper))

				if var_163_20 then
					var_163_20:EnableDynamicBone(false)
				end

				arg_160_1:ShowWeapon(var_163_19.transform, false)

				arg_160_1.var_[var_163_17 .. "Animator"] = var_163_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_160_1.var_[var_163_17 .. "Animator"].applyRootMotion = true
				arg_160_1.var_[var_163_17 .. "LipSync"] = var_163_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_163_21 = arg_160_1.actors_["10166ui_story"].transform

			if 3.8 < arg_160_1.time_ and arg_160_1.time_ <= 3.8 + arg_163_0 then
				arg_160_1.var_.moveOldPos10166ui_story = var_163_21.localPosition

				local var_163_22 = GameObjectTools.GetOrAddComponent(var_163_21.gameObject, typeof(DynamicBoneHelper))

				if var_163_22 then
					var_163_22:EnableDynamicBone(false)
				end
			end

			local var_163_23 = 0.001

			if 3.8 <= arg_160_1.time_ and arg_160_1.time_ < 3.8 + var_163_23 then
				var_163_21.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_160_1.time_ - 3.8) / var_163_23)
				var_163_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_21.position).x, (manager.ui.mainCamera.transform.position - var_163_21.position).y, (manager.ui.mainCamera.transform.position - var_163_21.position).z)
				var_163_21.localEulerAngles.z = 0
				var_163_21.localEulerAngles.x = 0
				var_163_21.localEulerAngles = var_163_21.localEulerAngles
			end

			if arg_160_1.time_ >= 3.8 + var_163_23 and arg_160_1.time_ < 3.8 + var_163_23 + arg_163_0 then
				var_163_21.localPosition = Vector3.New(0, -1.28, -5.73)
				var_163_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_21.position).x, (manager.ui.mainCamera.transform.position - var_163_21.position).y, (manager.ui.mainCamera.transform.position - var_163_21.position).z)
				var_163_21.localEulerAngles.z = 0
				var_163_21.localEulerAngles.x = 0
				var_163_21.localEulerAngles = var_163_21.localEulerAngles

				local var_163_24 = GameObjectTools.GetOrAddComponent(var_163_21.gameObject, typeof(DynamicBoneHelper))

				if var_163_24 then
					var_163_24:EnableDynamicBone(true)
				end
			end

			local var_163_25 = arg_160_1.actors_["10167ui_story"].transform

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 then
				arg_160_1.var_.moveOldPos10167ui_story = var_163_25.localPosition

				local var_163_26 = GameObjectTools.GetOrAddComponent(var_163_25.gameObject, typeof(DynamicBoneHelper))

				if var_163_26 then
					var_163_26:EnableDynamicBone(false)
				end
			end

			local var_163_27 = 0.001

			if 1.96599999815226 <= arg_160_1.time_ and arg_160_1.time_ < 1.96599999815226 + var_163_27 then
				var_163_25.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 1.96599999815226) / var_163_27)
				var_163_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_25.position).x, (manager.ui.mainCamera.transform.position - var_163_25.position).y, (manager.ui.mainCamera.transform.position - var_163_25.position).z)
				var_163_25.localEulerAngles.z = 0
				var_163_25.localEulerAngles.x = 0
				var_163_25.localEulerAngles = var_163_25.localEulerAngles
			end

			if arg_160_1.time_ >= 1.96599999815226 + var_163_27 and arg_160_1.time_ < 1.96599999815226 + var_163_27 + arg_163_0 then
				var_163_25.localPosition = Vector3.New(0, 100, 0)
				var_163_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_25.position).x, (manager.ui.mainCamera.transform.position - var_163_25.position).y, (manager.ui.mainCamera.transform.position - var_163_25.position).z)
				var_163_25.localEulerAngles.z = 0
				var_163_25.localEulerAngles.x = 0
				var_163_25.localEulerAngles = var_163_25.localEulerAngles

				local var_163_28 = GameObjectTools.GetOrAddComponent(var_163_25.gameObject, typeof(DynamicBoneHelper))

				if var_163_28 then
					var_163_28:EnableDynamicBone(true)
				end
			end

			local var_163_29 = arg_160_1.actors_["10166ui_story"]

			if 3.8 < arg_160_1.time_ and arg_160_1.time_ <= 3.8 + arg_163_0 and not isNil(var_163_29) and arg_160_1.var_.characterEffect10166ui_story == nil then
				arg_160_1.var_.characterEffect10166ui_story = var_163_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_30 = 0.200000002980232

			if 3.8 <= arg_160_1.time_ and arg_160_1.time_ < 3.8 + var_163_30 and not isNil(var_163_29) then
				if arg_160_1.var_.characterEffect10166ui_story and not isNil(var_163_29) then
					arg_160_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 3.8 + var_163_30 and arg_160_1.time_ < 3.8 + var_163_30 + arg_163_0 and not isNil(var_163_29) and arg_160_1.var_.characterEffect10166ui_story then
				arg_160_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 3.8 < arg_160_1.time_ and arg_160_1.time_ <= 3.8 + arg_163_0 then
				arg_160_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_1")
			end

			if 3.8 < arg_160_1.time_ and arg_160_1.time_ <= 3.8 + arg_163_0 then
				arg_160_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_32 = 3.96599999815226
			local var_163_33 = 0.425

			if 3.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= var_163_32 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_34 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_34:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_35 = arg_160_1:GetWordFromCfg(325571041)
				local var_163_36 = arg_160_1:FormatText(var_163_35.content)

				arg_160_1.text_.text = var_163_36

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_38 = 17 <= 0 and var_163_33 or var_163_33 * (utf8.len(var_163_36) / 17)

				if (17 <= 0 and var_163_33 or var_163_33 * (utf8.len(var_163_36) / 17)) > 0 and var_163_33 < var_163_38 then
					arg_160_1.talkMaxDuration = var_163_38
					var_163_32 = var_163_32 + 0.3

					if var_163_38 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_38 + var_163_32
					end
				end

				arg_160_1.text_.text = var_163_36
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571041", "story_v_out_325571.awb") ~= 0 then
					local var_163_39 = manager.audio:GetVoiceLength("story_v_out_325571", "325571041", "story_v_out_325571.awb") / 1000

					if var_163_39 + var_163_32 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_39 + var_163_32
					end

					if var_163_35.prefab_name ~= "" and arg_160_1.actors_[var_163_35.prefab_name] ~= nil then
						local var_163_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_35.prefab_name].transform, "story_v_out_325571", "325571041", "story_v_out_325571.awb")

						arg_160_1:RecordAudio("325571041", var_163_40)
						arg_160_1:RecordAudio("325571041", var_163_40)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325571", "325571041", "story_v_out_325571.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325571", "325571041", "story_v_out_325571.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_41 = var_163_32 + 0.3
			local var_163_42 = math.max(var_163_33, arg_160_1.talkMaxDuration)

			if var_163_32 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_41 + var_163_42 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_41) / var_163_42

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_41 + var_163_42 and arg_160_1.time_ < var_163_41 + var_163_42 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play325571042 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325571042
		arg_166_1.duration_ = 4.1

		local var_166_0 = {
			zh = 4.1,
			ja = 3.1
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325571043(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.35

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:GetWordFromCfg(325571042)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 14 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 14)

				if (14 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 14)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571042", "story_v_out_325571.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571042", "story_v_out_325571.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_out_325571", "325571042", "story_v_out_325571.awb")

						arg_166_1:RecordAudio("325571042", var_169_6)
						arg_166_1:RecordAudio("325571042", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_325571", "325571042", "story_v_out_325571.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_325571", "325571042", "story_v_out_325571.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325571043 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325571043
		arg_170_1.duration_ = 4.2

		local var_170_0 = {
			zh = 3.2,
			ja = 4.2
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325571044(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10166ui_story"]) and arg_170_1.var_.characterEffect10166ui_story == nil then
				arg_170_1.var_.characterEffect10166ui_story = arg_170_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10166ui_story"]) then
				if arg_170_1.var_.characterEffect10166ui_story and not isNil(arg_170_1.actors_["10166ui_story"]) then
					arg_170_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10166ui_story"]) and arg_170_1.var_.characterEffect10166ui_story then
				arg_170_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.325

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1531].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(325571043)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 13)

				if (13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 13)) > 0 and var_173_2 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571043", "story_v_out_325571.awb") ~= 0 then
					local var_173_7 = manager.audio:GetVoiceLength("story_v_out_325571", "325571043", "story_v_out_325571.awb") / 1000

					if var_173_7 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_1
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_325571", "325571043", "story_v_out_325571.awb")

						arg_170_1:RecordAudio("325571043", var_173_8)
						arg_170_1:RecordAudio("325571043", var_173_8)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325571", "325571043", "story_v_out_325571.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325571", "325571043", "story_v_out_325571.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_9 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_9 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_9

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_9 and arg_170_1.time_ < var_173_1 + var_173_9 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325571044 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325571044
		arg_174_1.duration_ = 7.97

		local var_174_0 = {
			zh = 6.166,
			ja = 7.966
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play325571045(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10166ui_story = arg_174_1.actors_["10166ui_story"].transform.localPosition

				local var_177_0 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_0 then
					var_177_0:EnableDynamicBone(false)
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_1)
				arg_174_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).z)
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles = arg_174_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10166ui_story"].transform.position).z)
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10166ui_story"].transform.localEulerAngles = arg_174_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_177_2 = GameObjectTools.GetOrAddComponent(arg_174_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(true)
				end
			end

			local var_177_3 = "10162ui_story"

			if arg_174_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_177_4 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_174_1.stage_.transform)

				var_177_4.name = var_177_3
				var_177_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_[var_177_3] = var_177_4

				local var_177_5 = var_177_4:GetComponentInChildren(typeof(CharacterEffect))

				var_177_5.enabled = true

				local var_177_6 = GameObjectTools.GetOrAddComponent(var_177_4, typeof(DynamicBoneHelper))

				if var_177_6 then
					var_177_6:EnableDynamicBone(false)
				end

				arg_174_1:ShowWeapon(var_177_5.transform, false)

				arg_174_1.var_[var_177_3 .. "Animator"] = var_177_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_174_1.var_[var_177_3 .. "Animator"].applyRootMotion = true
				arg_174_1.var_[var_177_3 .. "LipSync"] = var_177_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_177_7 = arg_174_1.actors_["10162ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10162ui_story = var_177_7.localPosition

				local var_177_8 = GameObjectTools.GetOrAddComponent(var_177_7.gameObject, typeof(DynamicBoneHelper))

				if var_177_8 then
					var_177_8:EnableDynamicBone(false)
				end
			end

			local var_177_9 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_9 then
				var_177_7.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_174_1.time_ - 0) / var_177_9)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_9 and arg_174_1.time_ < 0 + var_177_9 + arg_177_0 then
				var_177_7.localPosition = Vector3.New(0, -1.08, -5.83)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles

				local var_177_10 = GameObjectTools.GetOrAddComponent(var_177_7.gameObject, typeof(DynamicBoneHelper))

				if var_177_10 then
					var_177_10:EnableDynamicBone(true)
				end
			end

			local var_177_11 = arg_174_1.actors_["10162ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_11) and arg_174_1.var_.characterEffect10162ui_story == nil then
				arg_174_1.var_.characterEffect10162ui_story = var_177_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_12 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_12 and not isNil(var_177_11) then
				if arg_174_1.var_.characterEffect10162ui_story and not isNil(var_177_11) then
					arg_174_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_12 and arg_174_1.time_ < 0 + var_177_12 + arg_177_0 and not isNil(var_177_11) and arg_174_1.var_.characterEffect10162ui_story then
				arg_174_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_177_14 = arg_174_1.actors_["10166ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_14) and arg_174_1.var_.characterEffect10166ui_story == nil then
				arg_174_1.var_.characterEffect10166ui_story = var_177_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_15 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_15 and not isNil(var_177_14) then
				if arg_174_1.var_.characterEffect10166ui_story and not isNil(var_177_14) then
					arg_174_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_15)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_15 and arg_174_1.time_ < 0 + var_177_15 + arg_177_0 and not isNil(var_177_14) and arg_174_1.var_.characterEffect10166ui_story then
				arg_174_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_16 = 0
			local var_177_17 = 0.625

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_18 = arg_174_1:GetWordFromCfg(325571044)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_21 = 25 <= 0 and var_177_17 or var_177_17 * (utf8.len(var_177_19) / 25)

				if (25 <= 0 and var_177_17 or var_177_17 * (utf8.len(var_177_19) / 25)) > 0 and var_177_17 < var_177_21 then
					arg_174_1.talkMaxDuration = var_177_21

					if var_177_21 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_21 + var_177_16
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571044", "story_v_out_325571.awb") ~= 0 then
					local var_177_22 = manager.audio:GetVoiceLength("story_v_out_325571", "325571044", "story_v_out_325571.awb") / 1000

					if var_177_22 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_16
					end

					if var_177_18.prefab_name ~= "" and arg_174_1.actors_[var_177_18.prefab_name] ~= nil then
						local var_177_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_18.prefab_name].transform, "story_v_out_325571", "325571044", "story_v_out_325571.awb")

						arg_174_1:RecordAudio("325571044", var_177_23)
						arg_174_1:RecordAudio("325571044", var_177_23)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325571", "325571044", "story_v_out_325571.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325571", "325571044", "story_v_out_325571.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_24 = math.max(var_177_17, arg_174_1.talkMaxDuration)

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_24 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_16) / var_177_24

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_16 + var_177_24 and arg_174_1.time_ < var_177_16 + var_177_24 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play325571045 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325571045
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325571046(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10162ui_story = arg_178_1.actors_["10162ui_story"].transform.localPosition

				local var_181_0 = GameObjectTools.GetOrAddComponent(arg_178_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_181_0 then
					var_181_0:EnableDynamicBone(false)
				end
			end

			local var_181_1 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				arg_178_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_1)
				arg_178_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).z)
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles = arg_178_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 then
				arg_178_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["10162ui_story"].transform.position).z)
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["10162ui_story"].transform.localEulerAngles = arg_178_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_181_2 = GameObjectTools.GetOrAddComponent(arg_178_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_181_2 then
					var_181_2:EnableDynamicBone(true)
				end
			end

			local var_181_3 = arg_178_1.actors_["10162ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect10162ui_story == nil then
				arg_178_1.var_.characterEffect10162ui_story = var_181_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_4 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 and not isNil(var_181_3) then
				if arg_178_1.var_.characterEffect10162ui_story and not isNil(var_181_3) then
					arg_178_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_4)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect10162ui_story then
				arg_178_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_181_5 = 0
			local var_181_6 = 1.05

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_7 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(325571045).content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 42 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_7) / 42)

				if (42 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_7) / 42)) > 0 and var_181_6 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_5
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_6, arg_178_1.talkMaxDuration)

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_5) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_5 + var_181_10 and arg_178_1.time_ < var_181_5 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play325571046 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325571046
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play325571047(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.725

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(325571046).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 69 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 69)

				if (69 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 69)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325571047 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325571047
		arg_186_1.duration_ = 6.63

		local var_186_0 = {
			zh = 6.633,
			ja = 5.833
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325571048(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10166ui_story = arg_186_1.actors_["10166ui_story"].transform.localPosition

				local var_189_0 = GameObjectTools.GetOrAddComponent(arg_186_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_189_0 then
					var_189_0:EnableDynamicBone(false)
				end
			end

			local var_189_1 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 then
				arg_186_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_186_1.time_ - 0) / var_189_1)
				arg_186_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).z)
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles = arg_186_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 then
				arg_186_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_186_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10166ui_story"].transform.position).z)
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10166ui_story"].transform.localEulerAngles = arg_186_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_189_2 = GameObjectTools.GetOrAddComponent(arg_186_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_189_2 then
					var_189_2:EnableDynamicBone(true)
				end
			end

			local var_189_3 = arg_186_1.actors_["10166ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect10166ui_story == nil then
				arg_186_1.var_.characterEffect10166ui_story = var_189_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_4 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 and not isNil(var_189_3) then
				if arg_186_1.var_.characterEffect10166ui_story and not isNil(var_189_3) then
					arg_186_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect10166ui_story then
				arg_186_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_2")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_6 = 0
			local var_189_7 = 0.325

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(325571047)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 13 <= 0 and var_189_7 or var_189_7 * (utf8.len(var_189_9) / 13)

				if (13 <= 0 and var_189_7 or var_189_7 * (utf8.len(var_189_9) / 13)) > 0 and var_189_7 < var_189_11 then
					arg_186_1.talkMaxDuration = var_189_11

					if var_189_11 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571047", "story_v_out_325571.awb") ~= 0 then
					local var_189_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571047", "story_v_out_325571.awb") / 1000

					if var_189_12 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_6
					end

					if var_189_8.prefab_name ~= "" and arg_186_1.actors_[var_189_8.prefab_name] ~= nil then
						local var_189_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_8.prefab_name].transform, "story_v_out_325571", "325571047", "story_v_out_325571.awb")

						arg_186_1:RecordAudio("325571047", var_189_13)
						arg_186_1:RecordAudio("325571047", var_189_13)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325571", "325571047", "story_v_out_325571.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325571", "325571047", "story_v_out_325571.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_14 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_14 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_14

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_14 and arg_186_1.time_ < var_189_6 + var_189_14 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play325571048 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325571048
		arg_190_1.duration_ = 5.63

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play325571049(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_9000

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10166ui_story = arg_190_1.actors_["10166ui_story"].transform.localPosition

				local var_193_0 = GameObjectTools.GetOrAddComponent(arg_190_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_193_0 then
					var_193_0:EnableDynamicBone(false)
				end
			end

			local var_193_1 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_1 then
				arg_190_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_190_1.time_ - 0) / var_193_1)
				arg_190_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).z)
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles = arg_190_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_1 and arg_190_1.time_ < 0 + var_193_1 + arg_193_0 then
				arg_190_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["10166ui_story"].transform.position).z)
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["10166ui_story"].transform.localEulerAngles = arg_190_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_193_2 = GameObjectTools.GetOrAddComponent(arg_190_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_193_2 then
					var_193_2:EnableDynamicBone(true)
				end
			end

			local var_193_3 = arg_190_1.actors_["10166ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_3) and arg_190_1.var_.characterEffect10166ui_story == nil then
				arg_190_1.var_.characterEffect10166ui_story = var_193_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_4 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 and not isNil(var_193_3) then
				if arg_190_1.var_.characterEffect10166ui_story and not isNil(var_193_3) then
					arg_190_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_4)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 and not isNil(var_193_3) and arg_190_1.var_.characterEffect10166ui_story then
				arg_190_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				local var_193_5 = arg_190_1.var_.effectshuaijiao1

				if not arg_190_1.var_.effectshuaijiao1 then
					var_193_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_193_5.name = "shuaijiao1"
					arg_190_1.var_.effectshuaijiao1 = var_193_5
				else
					var_193_5.transform:SetParent(var_193_9000)
				end

				var_193_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_193_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.16666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 2.16666666666667 + arg_193_0 then
				if arg_190_1.var_.effectshuaijiao1 then
					Object.Destroy(arg_190_1.var_.effectshuaijiao1)

					arg_190_1.var_.effectshuaijiao1 = nil
				end
			end

			local var_193_8 = arg_190_1.bgs_.J21h.transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPosJ21h = var_193_8.localPosition
			end

			local var_193_9 = 0.633333333333333

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_9 then
				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPosJ21h, Vector3.New(0, 1, 9.5), (arg_190_1.time_ - 0) / var_193_9)
			end

			if arg_190_1.time_ >= 0 + var_193_9 and arg_190_1.time_ < 0 + var_193_9 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_193_10 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_10 + 2.16666666666667 and arg_190_1.time_ < var_193_10 + 2.16666666666667 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			if 0.1 < arg_190_1.time_ and arg_190_1.time_ <= 0.1 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_131", "se_story_131__fallmetal", "")
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_12 = 0.633333333333333
			local var_193_13 = 1.525

			if 0.633333333333333 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_14 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_14:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_15 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(325571048).content)

				arg_190_1.text_.text = var_193_15

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_17 = 61 <= 0 and var_193_13 or var_193_13 * (utf8.len(var_193_15) / 61)

				if (61 <= 0 and var_193_13 or var_193_13 * (utf8.len(var_193_15) / 61)) > 0 and var_193_13 < var_193_17 then
					arg_190_1.talkMaxDuration = var_193_17
					var_193_12 = var_193_12 + 0.3

					if var_193_17 + var_193_12 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_17 + var_193_12
					end
				end

				arg_190_1.text_.text = var_193_15
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_18 = var_193_12 + 0.3
			local var_193_19 = math.max(var_193_13, arg_190_1.talkMaxDuration)

			if var_193_12 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_18 + var_193_19 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_18) / var_193_19

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_18 + var_193_19 and arg_190_1.time_ < var_193_18 + var_193_19 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J21h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.633333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play325571049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325571049
		arg_196_1.duration_ = 2.83

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325571050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10166ui_story = arg_196_1.actors_["10166ui_story"].transform.localPosition

				local var_199_0 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_0 then
					var_199_0:EnableDynamicBone(false)
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_196_1.time_ - 0) / var_199_1)
				arg_196_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).z)
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles = arg_196_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_196_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10166ui_story"].transform.position).z)
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10166ui_story"].transform.localEulerAngles = arg_196_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_199_2 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(true)
				end
			end

			local var_199_3 = arg_196_1.actors_["10166ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect10166ui_story == nil then
				arg_196_1.var_.characterEffect10166ui_story = var_199_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_4 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 and not isNil(var_199_3) then
				if arg_196_1.var_.characterEffect10166ui_story and not isNil(var_199_3) then
					arg_196_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect10166ui_story then
				arg_196_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_6 = 0
			local var_199_7 = 0.2

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_8 = arg_196_1:GetWordFromCfg(325571049)
				local var_199_9 = arg_196_1:FormatText(var_199_8.content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 8 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 8)

				if (8 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 8)) > 0 and var_199_7 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571049", "story_v_out_325571.awb") ~= 0 then
					local var_199_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571049", "story_v_out_325571.awb") / 1000

					if var_199_12 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_6
					end

					if var_199_8.prefab_name ~= "" and arg_196_1.actors_[var_199_8.prefab_name] ~= nil then
						local var_199_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_8.prefab_name].transform, "story_v_out_325571", "325571049", "story_v_out_325571.awb")

						arg_196_1:RecordAudio("325571049", var_199_13)
						arg_196_1:RecordAudio("325571049", var_199_13)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325571", "325571049", "story_v_out_325571.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325571", "325571049", "story_v_out_325571.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play325571050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325571050
		arg_200_1.duration_ = 10.57

		local var_200_0 = {
			zh = 10.1,
			ja = 10.566
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325571051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10166ui_story = arg_200_1.actors_["10166ui_story"].transform.localPosition

				local var_203_0 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_0 then
					var_203_0:EnableDynamicBone(false)
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10166ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_200_1.time_ - 0) / var_203_1)
				arg_200_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).z)
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles = arg_200_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_200_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["10166ui_story"].transform.position).z)
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["10166ui_story"].transform.localEulerAngles = arg_200_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_203_2 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(true)
				end
			end

			local var_203_3 = arg_200_1.actors_["10162ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10162ui_story = var_203_3.localPosition

				local var_203_4 = GameObjectTools.GetOrAddComponent(var_203_3.gameObject, typeof(DynamicBoneHelper))

				if var_203_4 then
					var_203_4:EnableDynamicBone(false)
				end
			end

			local var_203_5 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_5 then
				var_203_3.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10162ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_200_1.time_ - 0) / var_203_5)
				var_203_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_3.position).x, (manager.ui.mainCamera.transform.position - var_203_3.position).y, (manager.ui.mainCamera.transform.position - var_203_3.position).z)
				var_203_3.localEulerAngles.z = 0
				var_203_3.localEulerAngles.x = 0
				var_203_3.localEulerAngles = var_203_3.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_5 and arg_200_1.time_ < 0 + var_203_5 + arg_203_0 then
				var_203_3.localPosition = Vector3.New(0.7, -1.08, -5.83)
				var_203_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_3.position).x, (manager.ui.mainCamera.transform.position - var_203_3.position).y, (manager.ui.mainCamera.transform.position - var_203_3.position).z)
				var_203_3.localEulerAngles.z = 0
				var_203_3.localEulerAngles.x = 0
				var_203_3.localEulerAngles = var_203_3.localEulerAngles

				local var_203_6 = GameObjectTools.GetOrAddComponent(var_203_3.gameObject, typeof(DynamicBoneHelper))

				if var_203_6 then
					var_203_6:EnableDynamicBone(true)
				end
			end

			local var_203_7 = arg_200_1.actors_["10162ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.characterEffect10162ui_story == nil then
				arg_200_1.var_.characterEffect10162ui_story = var_203_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_8 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_8 and not isNil(var_203_7) then
				if arg_200_1.var_.characterEffect10162ui_story and not isNil(var_203_7) then
					arg_200_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_8 and arg_200_1.time_ < 0 + var_203_8 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.characterEffect10162ui_story then
				arg_200_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_203_10 = arg_200_1.actors_["10166ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_10) and arg_200_1.var_.characterEffect10166ui_story == nil then
				arg_200_1.var_.characterEffect10166ui_story = var_203_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_11 and not isNil(var_203_10) then
				if arg_200_1.var_.characterEffect10166ui_story and not isNil(var_203_10) then
					arg_200_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_11)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_11 and arg_200_1.time_ < 0 + var_203_11 + arg_203_0 and not isNil(var_203_10) and arg_200_1.var_.characterEffect10166ui_story then
				arg_200_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_12 = 0
			local var_203_13 = 1.25

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_14 = arg_200_1:GetWordFromCfg(325571050)
				local var_203_15 = arg_200_1:FormatText(var_203_14.content)

				arg_200_1.text_.text = var_203_15

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_17 = 50 <= 0 and var_203_13 or var_203_13 * (utf8.len(var_203_15) / 50)

				if (50 <= 0 and var_203_13 or var_203_13 * (utf8.len(var_203_15) / 50)) > 0 and var_203_13 < var_203_17 then
					arg_200_1.talkMaxDuration = var_203_17

					if var_203_17 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_17 + var_203_12
					end
				end

				arg_200_1.text_.text = var_203_15
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571050", "story_v_out_325571.awb") ~= 0 then
					local var_203_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571050", "story_v_out_325571.awb") / 1000

					if var_203_18 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_18 + var_203_12
					end

					if var_203_14.prefab_name ~= "" and arg_200_1.actors_[var_203_14.prefab_name] ~= nil then
						local var_203_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_14.prefab_name].transform, "story_v_out_325571", "325571050", "story_v_out_325571.awb")

						arg_200_1:RecordAudio("325571050", var_203_19)
						arg_200_1:RecordAudio("325571050", var_203_19)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325571", "325571050", "story_v_out_325571.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325571", "325571050", "story_v_out_325571.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_20 = math.max(var_203_13, arg_200_1.talkMaxDuration)

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_20 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_12) / var_203_20

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_12 + var_203_20 and arg_200_1.time_ < var_203_12 + var_203_20 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play325571051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325571051
		arg_204_1.duration_ = 8.9

		local var_204_0 = {
			zh = 5.5,
			ja = 8.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325571052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41216")
			end

			local var_207_0 = 0
			local var_207_1 = 0.575

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(325571051)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 23 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_3) / 23)

				if (23 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_3) / 23)) > 0 and var_207_1 < var_207_5 then
					arg_204_1.talkMaxDuration = var_207_5

					if var_207_5 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571051", "story_v_out_325571.awb") ~= 0 then
					local var_207_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571051", "story_v_out_325571.awb") / 1000

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end

					if var_207_2.prefab_name ~= "" and arg_204_1.actors_[var_207_2.prefab_name] ~= nil then
						local var_207_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_2.prefab_name].transform, "story_v_out_325571", "325571051", "story_v_out_325571.awb")

						arg_204_1:RecordAudio("325571051", var_207_7)
						arg_204_1:RecordAudio("325571051", var_207_7)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325571", "325571051", "story_v_out_325571.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325571", "325571051", "story_v_out_325571.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play325571052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325571052
		arg_208_1.duration_ = 2.57

		local var_208_0 = {
			zh = 1.266,
			ja = 2.566
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325571053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["10166ui_story"]) and arg_208_1.var_.characterEffect10166ui_story == nil then
				arg_208_1.var_.characterEffect10166ui_story = arg_208_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["10166ui_story"]) then
				if arg_208_1.var_.characterEffect10166ui_story and not isNil(arg_208_1.actors_["10166ui_story"]) then
					arg_208_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["10166ui_story"]) and arg_208_1.var_.characterEffect10166ui_story then
				arg_208_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_211_2 = arg_208_1.actors_["10162ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect10162ui_story == nil then
				arg_208_1.var_.characterEffect10162ui_story = var_211_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.characterEffect10162ui_story and not isNil(var_211_2) then
					arg_208_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_3)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect10162ui_story then
				arg_208_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_211_4 = manager.ui.mainCamera.transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.shakeOldPos = var_211_4.localPosition
			end

			local var_211_5 = 0.4

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_5 then
				local var_211_6, var_211_7 = math.modf((arg_208_1.time_ - 0) / 0.066)

				var_211_4.localPosition = Vector3.New(var_211_7 * 0.13, var_211_7 * 0.13, var_211_7 * 0.13) + arg_208_1.var_.shakeOldPos
			end

			if arg_208_1.time_ >= 0 + var_211_5 and arg_208_1.time_ < 0 + var_211_5 + arg_211_0 then
				var_211_4.localPosition = arg_208_1.var_.shakeOldPos
			end

			local var_211_8 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_8 + 0.4 and arg_208_1.time_ < var_211_8 + 0.4 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_9 = arg_208_1.actors_["10166ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10166ui_story = var_211_9.localPosition

				local var_211_10 = GameObjectTools.GetOrAddComponent(var_211_9.gameObject, typeof(DynamicBoneHelper))

				if var_211_10 then
					var_211_10:EnableDynamicBone(false)
				end
			end

			local var_211_11 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_11 then
				var_211_9.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_11)
				var_211_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_9.position).x, (manager.ui.mainCamera.transform.position - var_211_9.position).y, (manager.ui.mainCamera.transform.position - var_211_9.position).z)
				var_211_9.localEulerAngles.z = 0
				var_211_9.localEulerAngles.x = 0
				var_211_9.localEulerAngles = var_211_9.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_11 and arg_208_1.time_ < 0 + var_211_11 + arg_211_0 then
				var_211_9.localPosition = Vector3.New(0, 100, 0)
				var_211_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_9.position).x, (manager.ui.mainCamera.transform.position - var_211_9.position).y, (manager.ui.mainCamera.transform.position - var_211_9.position).z)
				var_211_9.localEulerAngles.z = 0
				var_211_9.localEulerAngles.x = 0
				var_211_9.localEulerAngles = var_211_9.localEulerAngles

				local var_211_12 = GameObjectTools.GetOrAddComponent(var_211_9.gameObject, typeof(DynamicBoneHelper))

				if var_211_12 then
					var_211_12:EnableDynamicBone(true)
				end
			end

			local var_211_13 = arg_208_1.actors_["10162ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10162ui_story = var_211_13.localPosition

				local var_211_14 = GameObjectTools.GetOrAddComponent(var_211_13.gameObject, typeof(DynamicBoneHelper))

				if var_211_14 then
					var_211_14:EnableDynamicBone(false)
				end
			end

			local var_211_15 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_15 then
				var_211_13.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_15)
				var_211_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_13.position).x, (manager.ui.mainCamera.transform.position - var_211_13.position).y, (manager.ui.mainCamera.transform.position - var_211_13.position).z)
				var_211_13.localEulerAngles.z = 0
				var_211_13.localEulerAngles.x = 0
				var_211_13.localEulerAngles = var_211_13.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_15 and arg_208_1.time_ < 0 + var_211_15 + arg_211_0 then
				var_211_13.localPosition = Vector3.New(0, 100, 0)
				var_211_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_13.position).x, (manager.ui.mainCamera.transform.position - var_211_13.position).y, (manager.ui.mainCamera.transform.position - var_211_13.position).z)
				var_211_13.localEulerAngles.z = 0
				var_211_13.localEulerAngles.x = 0
				var_211_13.localEulerAngles = var_211_13.localEulerAngles

				local var_211_16 = GameObjectTools.GetOrAddComponent(var_211_13.gameObject, typeof(DynamicBoneHelper))

				if var_211_16 then
					var_211_16:EnableDynamicBone(true)
				end
			end

			local var_211_17 = arg_208_1.actors_["10166ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_17) and arg_208_1.var_.characterEffect10166ui_story == nil then
				arg_208_1.var_.characterEffect10166ui_story = var_211_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_18 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_18 and not isNil(var_211_17) then
				if arg_208_1.var_.characterEffect10166ui_story and not isNil(var_211_17) then
					arg_208_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_18)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_18 and arg_208_1.time_ < 0 + var_211_18 + arg_211_0 and not isNil(var_211_17) and arg_208_1.var_.characterEffect10166ui_story then
				arg_208_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_211_19 = 0
			local var_211_20 = 0.125

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_19 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1531].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_21 = arg_208_1:GetWordFromCfg(325571052)
				local var_211_22 = arg_208_1:FormatText(var_211_21.content)

				arg_208_1.text_.text = var_211_22

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_24 = 5 <= 0 and var_211_20 or var_211_20 * (utf8.len(var_211_22) / 5)

				if (5 <= 0 and var_211_20 or var_211_20 * (utf8.len(var_211_22) / 5)) > 0 and var_211_20 < var_211_24 then
					arg_208_1.talkMaxDuration = var_211_24

					if var_211_24 + var_211_19 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_24 + var_211_19
					end
				end

				arg_208_1.text_.text = var_211_22
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571052", "story_v_out_325571.awb") ~= 0 then
					local var_211_25 = manager.audio:GetVoiceLength("story_v_out_325571", "325571052", "story_v_out_325571.awb") / 1000

					if var_211_25 + var_211_19 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_25 + var_211_19
					end

					if var_211_21.prefab_name ~= "" and arg_208_1.actors_[var_211_21.prefab_name] ~= nil then
						local var_211_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_21.prefab_name].transform, "story_v_out_325571", "325571052", "story_v_out_325571.awb")

						arg_208_1:RecordAudio("325571052", var_211_26)
						arg_208_1:RecordAudio("325571052", var_211_26)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325571", "325571052", "story_v_out_325571.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325571", "325571052", "story_v_out_325571.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_27 = math.max(var_211_20, arg_208_1.talkMaxDuration)

			if var_211_19 <= arg_208_1.time_ and arg_208_1.time_ < var_211_19 + var_211_27 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_19) / var_211_27

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_19 + var_211_27 and arg_208_1.time_ < var_211_19 + var_211_27 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play325571053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325571053
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325571054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_fall", "")
			end

			local var_215_1 = 0
			local var_215_2 = 1.275

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(325571053).content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 51 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 51)

				if (51 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 51)) > 0 and var_215_2 < var_215_5 then
					arg_212_1.talkMaxDuration = var_215_5

					if var_215_5 + var_215_1 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + var_215_1
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_6 = math.max(var_215_2, arg_212_1.talkMaxDuration)

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_6 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_1) / var_215_6

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_1 + var_215_6 and arg_212_1.time_ < var_215_1 + var_215_6 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325571054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325571054
		arg_216_1.duration_ = 6.6

		local var_216_0 = {
			zh = 4.4,
			ja = 6.6
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325571055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10166ui_story = arg_216_1.actors_["10166ui_story"].transform.localPosition

				local var_219_0 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_0 then
					var_219_0:EnableDynamicBone(false)
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_216_1.time_ - 0) / var_219_1)
				arg_216_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).z)
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles = arg_216_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_216_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10166ui_story"].transform.position).z)
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10166ui_story"].transform.localEulerAngles = arg_216_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_219_2 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(true)
				end
			end

			local var_219_3 = arg_216_1.actors_["10166ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10166ui_story == nil then
				arg_216_1.var_.characterEffect10166ui_story = var_219_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_4 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.characterEffect10166ui_story and not isNil(var_219_3) then
					arg_216_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10166ui_story then
				arg_216_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_6 = 0
			local var_219_7 = 0.45

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(325571054)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 18 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 18)

				if (18 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 18)) > 0 and var_219_7 < var_219_11 then
					arg_216_1.talkMaxDuration = var_219_11

					if var_219_11 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_11 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571054", "story_v_out_325571.awb") ~= 0 then
					local var_219_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571054", "story_v_out_325571.awb") / 1000

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end

					if var_219_8.prefab_name ~= "" and arg_216_1.actors_[var_219_8.prefab_name] ~= nil then
						local var_219_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_8.prefab_name].transform, "story_v_out_325571", "325571054", "story_v_out_325571.awb")

						arg_216_1:RecordAudio("325571054", var_219_13)
						arg_216_1:RecordAudio("325571054", var_219_13)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_325571", "325571054", "story_v_out_325571.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_325571", "325571054", "story_v_out_325571.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play325571055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325571055
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325571056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10166ui_story = arg_220_1.actors_["10166ui_story"].transform.localPosition

				local var_223_0 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_0 then
					var_223_0:EnableDynamicBone(false)
				end
			end

			local var_223_1 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 then
				arg_220_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_1)
				arg_220_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).z)
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles = arg_220_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 then
				arg_220_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["10166ui_story"].transform.position).z)
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["10166ui_story"].transform.localEulerAngles = arg_220_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_223_2 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(true)
				end
			end

			local var_223_3 = arg_220_1.actors_["10166ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect10166ui_story == nil then
				arg_220_1.var_.characterEffect10166ui_story = var_223_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_4 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.characterEffect10166ui_story and not isNil(var_223_3) then
					arg_220_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_220_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_4)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect10166ui_story then
				arg_220_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_220_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_223_5 = 0
			local var_223_6 = 0.725

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_7 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(325571055).content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 29 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_7) / 29)

				if (29 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_7) / 29)) > 0 and var_223_6 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_5) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_5 + var_223_10 and arg_220_1.time_ < var_223_5 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play325571056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325571056
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325571057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(325571056).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 40 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 40)

				if (40 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 40)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play325571057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325571057
		arg_228_1.duration_ = 7.9

		local var_228_0 = {
			zh = 6.9,
			ja = 7.9
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325571058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10162ui_story = arg_228_1.actors_["10162ui_story"].transform.localPosition

				local var_231_0 = GameObjectTools.GetOrAddComponent(arg_228_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_231_0 then
					var_231_0:EnableDynamicBone(false)
				end
			end

			local var_231_1 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_1 then
				arg_228_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_228_1.time_ - 0) / var_231_1)
				arg_228_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).z)
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles = arg_228_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_1 and arg_228_1.time_ < 0 + var_231_1 + arg_231_0 then
				arg_228_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_228_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10162ui_story"].transform.position).z)
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10162ui_story"].transform.localEulerAngles = arg_228_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_231_2 = GameObjectTools.GetOrAddComponent(arg_228_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(true)
				end
			end

			local var_231_3 = arg_228_1.actors_["10162ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect10162ui_story == nil then
				arg_228_1.var_.characterEffect10162ui_story = var_231_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_4 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 and not isNil(var_231_3) then
				if arg_228_1.var_.characterEffect10162ui_story and not isNil(var_231_3) then
					arg_228_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect10162ui_story then
				arg_228_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_231_6 = 0
			local var_231_7 = 0.725

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_8 = arg_228_1:GetWordFromCfg(325571057)
				local var_231_9 = arg_228_1:FormatText(var_231_8.content)

				arg_228_1.text_.text = var_231_9

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 29 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 29)

				if (29 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 29)) > 0 and var_231_7 < var_231_11 then
					arg_228_1.talkMaxDuration = var_231_11

					if var_231_11 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_9
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571057", "story_v_out_325571.awb") ~= 0 then
					local var_231_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571057", "story_v_out_325571.awb") / 1000

					if var_231_12 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_12 + var_231_6
					end

					if var_231_8.prefab_name ~= "" and arg_228_1.actors_[var_231_8.prefab_name] ~= nil then
						local var_231_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_8.prefab_name].transform, "story_v_out_325571", "325571057", "story_v_out_325571.awb")

						arg_228_1:RecordAudio("325571057", var_231_13)
						arg_228_1:RecordAudio("325571057", var_231_13)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325571", "325571057", "story_v_out_325571.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325571", "325571057", "story_v_out_325571.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play325571058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325571058
		arg_232_1.duration_ = 3.1

		local var_232_0 = {
			zh = 2.466,
			ja = 3.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325571059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10162ui_story = arg_232_1.actors_["10162ui_story"].transform.localPosition

				local var_235_0 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_0 then
					var_235_0:EnableDynamicBone(false)
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_232_1.time_ - 0) / var_235_1)
				arg_232_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).z)
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles = arg_232_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_232_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10162ui_story"].transform.position).z)
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10162ui_story"].transform.localEulerAngles = arg_232_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_235_2 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(true)
				end
			end

			local var_235_3 = arg_232_1.actors_["10166ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10166ui_story = var_235_3.localPosition

				local var_235_4 = GameObjectTools.GetOrAddComponent(var_235_3.gameObject, typeof(DynamicBoneHelper))

				if var_235_4 then
					var_235_4:EnableDynamicBone(false)
				end
			end

			local var_235_5 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_5 then
				var_235_3.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_5)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_5 and arg_232_1.time_ < 0 + var_235_5 + arg_235_0 then
				var_235_3.localPosition = Vector3.New(0, 100, 0)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles

				local var_235_6 = GameObjectTools.GetOrAddComponent(var_235_3.gameObject, typeof(DynamicBoneHelper))

				if var_235_6 then
					var_235_6:EnableDynamicBone(true)
				end
			end

			local var_235_7 = arg_232_1.actors_["10166ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_7) and arg_232_1.var_.characterEffect10166ui_story == nil then
				arg_232_1.var_.characterEffect10166ui_story = var_235_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_8 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_8 and not isNil(var_235_7) then
				if arg_232_1.var_.characterEffect10166ui_story and not isNil(var_235_7) then
					arg_232_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_8 and arg_232_1.time_ < 0 + var_235_8 + arg_235_0 and not isNil(var_235_7) and arg_232_1.var_.characterEffect10166ui_story then
				arg_232_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_235_10 = arg_232_1.actors_["10162ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_10) and arg_232_1.var_.characterEffect10162ui_story == nil then
				arg_232_1.var_.characterEffect10162ui_story = var_235_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_11 and not isNil(var_235_10) then
				if arg_232_1.var_.characterEffect10162ui_story and not isNil(var_235_10) then
					arg_232_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_11)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_11 and arg_232_1.time_ < 0 + var_235_11 + arg_235_0 and not isNil(var_235_10) and arg_232_1.var_.characterEffect10162ui_story then
				arg_232_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_12 = 0
			local var_235_13 = 0.2

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1531].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_14 = arg_232_1:GetWordFromCfg(325571058)
				local var_235_15 = arg_232_1:FormatText(var_235_14.content)

				arg_232_1.text_.text = var_235_15

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_17 = 8 <= 0 and var_235_13 or var_235_13 * (utf8.len(var_235_15) / 8)

				if (8 <= 0 and var_235_13 or var_235_13 * (utf8.len(var_235_15) / 8)) > 0 and var_235_13 < var_235_17 then
					arg_232_1.talkMaxDuration = var_235_17

					if var_235_17 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_17 + var_235_12
					end
				end

				arg_232_1.text_.text = var_235_15
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571058", "story_v_out_325571.awb") ~= 0 then
					local var_235_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571058", "story_v_out_325571.awb") / 1000

					if var_235_18 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_18 + var_235_12
					end

					if var_235_14.prefab_name ~= "" and arg_232_1.actors_[var_235_14.prefab_name] ~= nil then
						local var_235_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_14.prefab_name].transform, "story_v_out_325571", "325571058", "story_v_out_325571.awb")

						arg_232_1:RecordAudio("325571058", var_235_19)
						arg_232_1:RecordAudio("325571058", var_235_19)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325571", "325571058", "story_v_out_325571.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325571", "325571058", "story_v_out_325571.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_20 = math.max(var_235_13, arg_232_1.talkMaxDuration)

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_20 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_12) / var_235_20

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_12 + var_235_20 and arg_232_1.time_ < var_235_12 + var_235_20 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play325571059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325571059
		arg_236_1.duration_ = 6.17

		local var_236_0 = {
			zh = 5.9,
			ja = 6.166
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325571060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10166ui_story = arg_236_1.actors_["10166ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).z)
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles = arg_236_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_236_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10166ui_story"].transform.position).z)
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10166ui_story"].transform.localEulerAngles = arg_236_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = arg_236_1.actors_["10162ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10162ui_story = var_239_3.localPosition

				local var_239_4 = GameObjectTools.GetOrAddComponent(var_239_3.gameObject, typeof(DynamicBoneHelper))

				if var_239_4 then
					var_239_4:EnableDynamicBone(false)
				end
			end

			local var_239_5 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_5 then
				var_239_3.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_5)
				var_239_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_3.position).x, (manager.ui.mainCamera.transform.position - var_239_3.position).y, (manager.ui.mainCamera.transform.position - var_239_3.position).z)
				var_239_3.localEulerAngles.z = 0
				var_239_3.localEulerAngles.x = 0
				var_239_3.localEulerAngles = var_239_3.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_5 and arg_236_1.time_ < 0 + var_239_5 + arg_239_0 then
				var_239_3.localPosition = Vector3.New(0, 100, 0)
				var_239_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_3.position).x, (manager.ui.mainCamera.transform.position - var_239_3.position).y, (manager.ui.mainCamera.transform.position - var_239_3.position).z)
				var_239_3.localEulerAngles.z = 0
				var_239_3.localEulerAngles.x = 0
				var_239_3.localEulerAngles = var_239_3.localEulerAngles

				local var_239_6 = GameObjectTools.GetOrAddComponent(var_239_3.gameObject, typeof(DynamicBoneHelper))

				if var_239_6 then
					var_239_6:EnableDynamicBone(true)
				end
			end

			local var_239_7 = 0
			local var_239_8 = 0.6

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_7 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_9 = arg_236_1:GetWordFromCfg(325571059)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_12 = 24 <= 0 and var_239_8 or var_239_8 * (utf8.len(var_239_10) / 24)

				if (24 <= 0 and var_239_8 or var_239_8 * (utf8.len(var_239_10) / 24)) > 0 and var_239_8 < var_239_12 then
					arg_236_1.talkMaxDuration = var_239_12

					if var_239_12 + var_239_7 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_12 + var_239_7
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571059", "story_v_out_325571.awb") ~= 0 then
					local var_239_13 = manager.audio:GetVoiceLength("story_v_out_325571", "325571059", "story_v_out_325571.awb") / 1000

					if var_239_13 + var_239_7 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_7
					end

					if var_239_9.prefab_name ~= "" and arg_236_1.actors_[var_239_9.prefab_name] ~= nil then
						local var_239_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_9.prefab_name].transform, "story_v_out_325571", "325571059", "story_v_out_325571.awb")

						arg_236_1:RecordAudio("325571059", var_239_14)
						arg_236_1:RecordAudio("325571059", var_239_14)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325571", "325571059", "story_v_out_325571.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325571", "325571059", "story_v_out_325571.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_15 = math.max(var_239_8, arg_236_1.talkMaxDuration)

			if var_239_7 <= arg_236_1.time_ and arg_236_1.time_ < var_239_7 + var_239_15 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_7) / var_239_15

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_7 + var_239_15 and arg_236_1.time_ < var_239_7 + var_239_15 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play325571060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325571060
		arg_240_1.duration_ = 2.13

		local var_240_0 = {
			zh = 2.133,
			ja = 1.999999999999
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325571061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10166ui_story = arg_240_1.actors_["10166ui_story"].transform.localPosition

				local var_243_0 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_0 then
					var_243_0:EnableDynamicBone(false)
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_1)
				arg_240_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).z)
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles = arg_240_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10166ui_story"].transform.position).z)
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10166ui_story"].transform.localEulerAngles = arg_240_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_243_2 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(true)
				end
			end

			local var_243_3 = arg_240_1.actors_["10175ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10175ui_story = var_243_3.localPosition

				local var_243_4 = GameObjectTools.GetOrAddComponent(var_243_3.gameObject, typeof(DynamicBoneHelper))

				if var_243_4 then
					var_243_4:EnableDynamicBone(false)
				end
			end

			local var_243_5 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_5 then
				var_243_3.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_240_1.time_ - 0) / var_243_5)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_5 and arg_240_1.time_ < 0 + var_243_5 + arg_243_0 then
				var_243_3.localPosition = Vector3.New(0, -1, -6.05)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles

				local var_243_6 = GameObjectTools.GetOrAddComponent(var_243_3.gameObject, typeof(DynamicBoneHelper))

				if var_243_6 then
					var_243_6:EnableDynamicBone(true)
				end
			end

			local var_243_7 = arg_240_1.actors_["10175ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_7) and arg_240_1.var_.characterEffect10175ui_story == nil then
				arg_240_1.var_.characterEffect10175ui_story = var_243_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_8 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_8 and not isNil(var_243_7) then
				if arg_240_1.var_.characterEffect10175ui_story and not isNil(var_243_7) then
					arg_240_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_8 and arg_240_1.time_ < 0 + var_243_8 + arg_243_0 and not isNil(var_243_7) and arg_240_1.var_.characterEffect10175ui_story then
				arg_240_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_243_10 = arg_240_1.actors_["10166ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_10) and arg_240_1.var_.characterEffect10166ui_story == nil then
				arg_240_1.var_.characterEffect10166ui_story = var_243_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_11 and not isNil(var_243_10) then
				if arg_240_1.var_.characterEffect10166ui_story and not isNil(var_243_10) then
					arg_240_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_11)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_11 and arg_240_1.time_ < 0 + var_243_11 + arg_243_0 and not isNil(var_243_10) and arg_240_1.var_.characterEffect10166ui_story then
				arg_240_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_243_12 = 0
			local var_243_13 = 0.15

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_14 = arg_240_1:GetWordFromCfg(325571060)
				local var_243_15 = arg_240_1:FormatText(var_243_14.content)

				arg_240_1.text_.text = var_243_15

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_17 = 6 <= 0 and var_243_13 or var_243_13 * (utf8.len(var_243_15) / 6)

				if (6 <= 0 and var_243_13 or var_243_13 * (utf8.len(var_243_15) / 6)) > 0 and var_243_13 < var_243_17 then
					arg_240_1.talkMaxDuration = var_243_17

					if var_243_17 + var_243_12 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_17 + var_243_12
					end
				end

				arg_240_1.text_.text = var_243_15
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571060", "story_v_out_325571.awb") ~= 0 then
					local var_243_18 = manager.audio:GetVoiceLength("story_v_out_325571", "325571060", "story_v_out_325571.awb") / 1000

					if var_243_18 + var_243_12 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_18 + var_243_12
					end

					if var_243_14.prefab_name ~= "" and arg_240_1.actors_[var_243_14.prefab_name] ~= nil then
						local var_243_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_14.prefab_name].transform, "story_v_out_325571", "325571060", "story_v_out_325571.awb")

						arg_240_1:RecordAudio("325571060", var_243_19)
						arg_240_1:RecordAudio("325571060", var_243_19)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325571", "325571060", "story_v_out_325571.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325571", "325571060", "story_v_out_325571.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_20 = math.max(var_243_13, arg_240_1.talkMaxDuration)

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_20 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_12) / var_243_20

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_12 + var_243_20 and arg_240_1.time_ < var_243_12 + var_243_20 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play325571061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325571061
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325571062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10175ui_story = arg_244_1.actors_["10175ui_story"].transform.localPosition

				local var_247_0 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_0 then
					var_247_0:EnableDynamicBone(false)
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_1)
				arg_244_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).z)
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles = arg_244_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["10175ui_story"].transform.position).z)
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["10175ui_story"].transform.localEulerAngles = arg_244_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_247_2 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_2 then
					var_247_2:EnableDynamicBone(true)
				end
			end

			local var_247_3 = arg_244_1.actors_["10175ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect10175ui_story == nil then
				arg_244_1.var_.characterEffect10175ui_story = var_247_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_4 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 and not isNil(var_247_3) then
				if arg_244_1.var_.characterEffect10175ui_story and not isNil(var_247_3) then
					arg_244_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_4)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect10175ui_story then
				arg_244_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_247_5 = 0
			local var_247_6 = 1.75

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(325571061).content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 70 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 70)

				if (70 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 70)) > 0 and var_247_6 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_10 and arg_244_1.time_ < var_247_5 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play325571062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325571062
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325571063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.8

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(325571062).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 32 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 32)

				if (32 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 32)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play325571063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325571063
		arg_252_1.duration_ = 10.03

		local var_252_0 = {
			zh = 7.466,
			ja = 10.033
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325571064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10175ui_story = arg_252_1.actors_["10175ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).z)
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles = arg_252_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_252_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10175ui_story"].transform.position).z)
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10175ui_story"].transform.localEulerAngles = arg_252_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = arg_252_1.actors_["10175ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect10175ui_story == nil then
				arg_252_1.var_.characterEffect10175ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect10175ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect10175ui_story then
				arg_252_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_6 = 0
			local var_255_7 = 0.675

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(325571063)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 27 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 27)

				if (27 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 27)) > 0 and var_255_7 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571063", "story_v_out_325571.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571063", "story_v_out_325571.awb") / 1000

					if var_255_12 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_6
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_325571", "325571063", "story_v_out_325571.awb")

						arg_252_1:RecordAudio("325571063", var_255_13)
						arg_252_1:RecordAudio("325571063", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325571", "325571063", "story_v_out_325571.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325571", "325571063", "story_v_out_325571.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play325571064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325571064
		arg_256_1.duration_ = 18.43

		local var_256_0 = {
			zh = 10.333,
			ja = 18.433
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325571065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.1

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:GetWordFromCfg(325571064)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 44 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 44)

				if (44 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 44)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571064", "story_v_out_325571.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571064", "story_v_out_325571.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_325571", "325571064", "story_v_out_325571.awb")

						arg_256_1:RecordAudio("325571064", var_259_6)
						arg_256_1:RecordAudio("325571064", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325571", "325571064", "story_v_out_325571.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325571", "325571064", "story_v_out_325571.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325571065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325571065
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play325571066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10175ui_story = arg_260_1.actors_["10175ui_story"].transform.localPosition

				local var_263_0 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_0 then
					var_263_0:EnableDynamicBone(false)
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_1)
				arg_260_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).z)
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles = arg_260_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10175ui_story"].transform.position).z)
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10175ui_story"].transform.localEulerAngles = arg_260_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_263_2 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(true)
				end
			end

			local var_263_3 = arg_260_1.actors_["10175ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect10175ui_story == nil then
				arg_260_1.var_.characterEffect10175ui_story = var_263_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_4 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 and not isNil(var_263_3) then
				if arg_260_1.var_.characterEffect10175ui_story and not isNil(var_263_3) then
					arg_260_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_4)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect10175ui_story then
				arg_260_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_263_5 = 0
			local var_263_6 = 0.875

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(325571065).content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 35 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 35)

				if (35 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_7) / 35)) > 0 and var_263_6 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_10 and arg_260_1.time_ < var_263_5 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play325571066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325571066
		arg_264_1.duration_ = 3.17

		local var_264_0 = {
			zh = 2.7,
			ja = 3.166
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325571067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10175ui_story = arg_264_1.actors_["10175ui_story"].transform.localPosition

				local var_267_0 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_0 then
					var_267_0:EnableDynamicBone(false)
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_264_1.time_ - 0) / var_267_1)
				arg_264_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).z)
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles = arg_264_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_264_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10175ui_story"].transform.position).z)
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["10175ui_story"].transform.localEulerAngles = arg_264_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_267_2 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(true)
				end
			end

			local var_267_3 = arg_264_1.actors_["10175ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10175ui_story == nil then
				arg_264_1.var_.characterEffect10175ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect10175ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10175ui_story then
				arg_264_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_2")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.25

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_8 = arg_264_1:GetWordFromCfg(325571066)
				local var_267_9 = arg_264_1:FormatText(var_267_8.content)

				arg_264_1.text_.text = var_267_9

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 10 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 10)

				if (10 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 10)) > 0 and var_267_7 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_9
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571066", "story_v_out_325571.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571066", "story_v_out_325571.awb") / 1000

					if var_267_12 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_6
					end

					if var_267_8.prefab_name ~= "" and arg_264_1.actors_[var_267_8.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_8.prefab_name].transform, "story_v_out_325571", "325571066", "story_v_out_325571.awb")

						arg_264_1:RecordAudio("325571066", var_267_13)
						arg_264_1:RecordAudio("325571066", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325571", "325571066", "story_v_out_325571.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325571", "325571066", "story_v_out_325571.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_14 and arg_264_1.time_ < var_267_6 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play325571067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325571067
		arg_268_1.duration_ = 11.7

		local var_268_0 = {
			zh = 11.7,
			ja = 10
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325571068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.325

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(325571067)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 53 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 53)

				if (53 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 53)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571067", "story_v_out_325571.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571067", "story_v_out_325571.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_325571", "325571067", "story_v_out_325571.awb")

						arg_268_1:RecordAudio("325571067", var_271_6)
						arg_268_1:RecordAudio("325571067", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325571", "325571067", "story_v_out_325571.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325571", "325571067", "story_v_out_325571.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325571068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325571068
		arg_272_1.duration_ = 10.83

		local var_272_0 = {
			zh = 6.2,
			ja = 10.833
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play325571069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_275_0 = 0
			local var_275_1 = 0.6

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_2 = arg_272_1:GetWordFromCfg(325571068)
				local var_275_3 = arg_272_1:FormatText(var_275_2.content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 24 <= 0 and var_275_1 or var_275_1 * (utf8.len(var_275_3) / 24)

				if (24 <= 0 and var_275_1 or var_275_1 * (utf8.len(var_275_3) / 24)) > 0 and var_275_1 < var_275_5 then
					arg_272_1.talkMaxDuration = var_275_5

					if var_275_5 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571068", "story_v_out_325571.awb") ~= 0 then
					local var_275_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571068", "story_v_out_325571.awb") / 1000

					if var_275_6 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_0
					end

					if var_275_2.prefab_name ~= "" and arg_272_1.actors_[var_275_2.prefab_name] ~= nil then
						local var_275_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_2.prefab_name].transform, "story_v_out_325571", "325571068", "story_v_out_325571.awb")

						arg_272_1:RecordAudio("325571068", var_275_7)
						arg_272_1:RecordAudio("325571068", var_275_7)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325571", "325571068", "story_v_out_325571.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325571", "325571068", "story_v_out_325571.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_8 and arg_272_1.time_ < var_275_0 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play325571069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325571069
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325571070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10175ui_story = arg_276_1.actors_["10175ui_story"].transform.localPosition

				local var_279_0 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_0 then
					var_279_0:EnableDynamicBone(false)
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_276_1.time_ - 0) / var_279_1)
				arg_276_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).z)
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles = arg_276_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10175ui_story"].transform.position).z)
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["10175ui_story"].transform.localEulerAngles = arg_276_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_279_2 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(true)
				end
			end

			local var_279_3 = arg_276_1.actors_["10175ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect10175ui_story == nil then
				arg_276_1.var_.characterEffect10175ui_story = var_279_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_4 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 and not isNil(var_279_3) then
				if arg_276_1.var_.characterEffect10175ui_story and not isNil(var_279_3) then
					arg_276_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_4)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect10175ui_story then
				arg_276_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_279_5 = 0
			local var_279_6 = 1.1

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_7 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(325571069).content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_9 = 44 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_7) / 44)

				if (44 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_7) / 44)) > 0 and var_279_6 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9

					if var_279_9 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_10 and arg_276_1.time_ < var_279_5 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play325571070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325571070
		arg_280_1.duration_ = 11.17

		local var_280_0 = {
			zh = 7.5,
			ja = 11.166
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play325571071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10175ui_story = arg_280_1.actors_["10175ui_story"].transform.localPosition

				local var_283_0 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_0 then
					var_283_0:EnableDynamicBone(false)
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_280_1.time_ - 0) / var_283_1)
				arg_280_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).z)
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles = arg_280_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_280_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10175ui_story"].transform.position).z)
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10175ui_story"].transform.localEulerAngles = arg_280_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_283_2 = GameObjectTools.GetOrAddComponent(arg_280_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_283_2 then
					var_283_2:EnableDynamicBone(true)
				end
			end

			local var_283_3 = arg_280_1.actors_["10175ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10175ui_story == nil then
				arg_280_1.var_.characterEffect10175ui_story = var_283_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_4 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 and not isNil(var_283_3) then
				if arg_280_1.var_.characterEffect10175ui_story and not isNil(var_283_3) then
					arg_280_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect10175ui_story then
				arg_280_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_283_6 = 0
			local var_283_7 = 0.85

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(325571070)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 34 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 34)

				if (34 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 34)) > 0 and var_283_7 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571070", "story_v_out_325571.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_out_325571", "325571070", "story_v_out_325571.awb") / 1000

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end

					if var_283_8.prefab_name ~= "" and arg_280_1.actors_[var_283_8.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_8.prefab_name].transform, "story_v_out_325571", "325571070", "story_v_out_325571.awb")

						arg_280_1:RecordAudio("325571070", var_283_13)
						arg_280_1:RecordAudio("325571070", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325571", "325571070", "story_v_out_325571.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325571", "325571070", "story_v_out_325571.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_14 and arg_280_1.time_ < var_283_6 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play325571071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325571071
		arg_284_1.duration_ = 8

		local var_284_0 = {
			zh = 7.133,
			ja = 8
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325571072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_287_0 = 0
			local var_287_1 = 0.8

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(325571071)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 32 <= 0 and var_287_1 or var_287_1 * (utf8.len(var_287_3) / 32)

				if (32 <= 0 and var_287_1 or var_287_1 * (utf8.len(var_287_3) / 32)) > 0 and var_287_1 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571071", "story_v_out_325571.awb") ~= 0 then
					local var_287_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571071", "story_v_out_325571.awb") / 1000

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end

					if var_287_2.prefab_name ~= "" and arg_284_1.actors_[var_287_2.prefab_name] ~= nil then
						local var_287_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_2.prefab_name].transform, "story_v_out_325571", "325571071", "story_v_out_325571.awb")

						arg_284_1:RecordAudio("325571071", var_287_7)
						arg_284_1:RecordAudio("325571071", var_287_7)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325571", "325571071", "story_v_out_325571.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325571", "325571071", "story_v_out_325571.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_8 and arg_284_1.time_ < var_287_0 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325571072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325571072
		arg_288_1.duration_ = 17.7

		local var_288_0 = {
			zh = 12.8,
			ja = 17.7
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play325571073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.5

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(325571072)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 60 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 60)

				if (60 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 60)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571072", "story_v_out_325571.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_325571", "325571072", "story_v_out_325571.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_325571", "325571072", "story_v_out_325571.awb")

						arg_288_1:RecordAudio("325571072", var_291_6)
						arg_288_1:RecordAudio("325571072", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325571", "325571072", "story_v_out_325571.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325571", "325571072", "story_v_out_325571.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play325571073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325571073
		arg_292_1.duration_ = 14.7

		local var_292_0 = {
			zh = 10.466,
			ja = 14.7
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play325571074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action2_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_295_0 = 0
			local var_295_1 = 1.025

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(325571073)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 41 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 41)

				if (41 <= 0 and var_295_1 or var_295_1 * (utf8.len(var_295_3) / 41)) > 0 and var_295_1 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325571", "325571073", "story_v_out_325571.awb") ~= 0 then
					local var_295_6 = manager.audio:GetVoiceLength("story_v_out_325571", "325571073", "story_v_out_325571.awb") / 1000

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end

					if var_295_2.prefab_name ~= "" and arg_292_1.actors_[var_295_2.prefab_name] ~= nil then
						local var_295_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_2.prefab_name].transform, "story_v_out_325571", "325571073", "story_v_out_325571.awb")

						arg_292_1:RecordAudio("325571073", var_295_7)
						arg_292_1:RecordAudio("325571073", var_295_7)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325571", "325571073", "story_v_out_325571.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325571", "325571073", "story_v_out_325571.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play325571074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325571074
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325571075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10175ui_story = arg_296_1.actors_["10175ui_story"].transform.localPosition

				local var_299_0 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_0 then
					var_299_0:EnableDynamicBone(false)
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_1)
				arg_296_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).z)
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles = arg_296_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10175ui_story"].transform.position).z)
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["10175ui_story"].transform.localEulerAngles = arg_296_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_299_2 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(true)
				end
			end

			local var_299_3 = arg_296_1.actors_["10175ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_3) and arg_296_1.var_.characterEffect10175ui_story == nil then
				arg_296_1.var_.characterEffect10175ui_story = var_299_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_4 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 and not isNil(var_299_3) then
				if arg_296_1.var_.characterEffect10175ui_story and not isNil(var_299_3) then
					arg_296_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_296_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_4)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 and not isNil(var_299_3) and arg_296_1.var_.characterEffect10175ui_story then
				arg_296_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_296_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_299_5 = 0
			local var_299_6 = 1.075

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_7 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(325571074).content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 43 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_7) / 43)

				if (43 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_7) / 43)) > 0 and var_299_6 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_5
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_6, arg_296_1.talkMaxDuration)

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_5) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_5 + var_299_10 and arg_296_1.time_ < var_299_5 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play325571075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325571075
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play325571076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.625

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(325571075).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 25 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 25)

				if (25 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 25)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play325571076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325571076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
			arg_304_1.auto_ = false
		end

		function arg_304_1.playNext_(arg_306_0)
			arg_304_1.onStoryFinished_()
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_307_1 = 0
			local var_307_2 = 1.175

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(325571076).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 47 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 47)

				if (47 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 47)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2006a",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_325571.awb"
	}
}
